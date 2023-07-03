import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/CustomerService.dart';
import 'package:gogi/components/custom_surfix_icon.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/components/form_error.dart';
import 'package:gogi/screens/customers/customers_screen.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../SharedPref.dart';
import '../../../constants.dart';
import '../../../models/Address.dart';
import '../../../models/Customer.dart';
import '../../../models/Request/CustomerRequest.dart';
import '../../../size_config.dart';
import '../../profile/profile_screen.dart';

class AddCustomerForm extends StatefulWidget {
  @override
  State<AddCustomerForm> createState() => AddCustomerFormState();
}

class AddCustomerFormState extends State<AddCustomerForm> {
  SharedPref sharedPref = SharedPref();
  CustomerService customerService = CustomerService();
  String accountUsername = '';

  //address
  Client client = Client();
  String host = "https://provinces.open-api.vn/api/?depth=2";
  var data;
  List<Province> provinces = [];
  List<District> districts = [];
  int provinceId = 0, districtId = 0;
  String provinceName = '', districtName = '';
  int? provinceValue, districtValue;

  @override
  void initState() {
    getProvinces();
    loadUsername();
    super.initState();
  }

  loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accountUsername = prefs.getString('username')!;
    });
  }

  Future<void> getProvinces() async {
    final res = await client.get(
      Uri.parse(host),
      headers: {"content-type": "application/json; charset=UTF-8"},
    );
    if (res.statusCode == 200) {
      setState(() {
        data = jsonDecode(utf8.decode(res.bodyBytes));
        provinces = List<Province>.from(data.map((i) {
          return Province.fromJSON(i);
        }));
      });
    } else {
      print("Error during fetching data");
    }
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? name;
  String? address;
  String? phoneNumber;
  int id = 0;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void clearError() {
    setState(() {
      errors.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          const Text(
            "Địa chỉ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Column(
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: provinceValue,
                    hint: const Text("Chọn Tỉnh/TP"),
                    onChanged: (int? value) {
                      setState(() {
                        provinceValue = value!;
                        provinceId = value;
                        getNameProvince(value);
                        districtValue = null;
                      });
                      getDistrictList(value!);
                    },
                    items: provinces.map((p) {
                      return DropdownMenuItem(
                        value: p.code,
                        child: Text(p.name), //value of item
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: districtValue,
                    hint: const Text("Chọn Quận/Huyện"),
                    items: districts.map((d) {
                      return DropdownMenuItem(
                        value: d.code,
                        child: Text(d.name), //value of item
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        districtValue = value!;
                        districtId = value;
                        getNameDistrict(value);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Lưu",
            press: () {
              String name = _controllerName.text.toString();
              String phone = _controllerPhoneNumber.text.toString();
              String address =
                  '${_controllerAddress.text}, $districtName, $provinceName';
              CustomerRequest customer = CustomerRequest(
                  name: name,
                  phone: phone,
                  address: address,
                  districtId: districtId,
                  provinceId: provinceId,
                  isDefault: false,
                  accountUsername: accountUsername);
              clearError();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                customerService.postCustomer(customer).then((value) {
                  if (value == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (context) => ProfileScreen()),
                      (_) => false,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomersScreen()));
                  } else {
                    addError(error: "Thêm địa chỉ không thành công");
                    return "";
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        controller: _controllerAddress,
        onSaved: (newValue) => address = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Địa chỉ",
          hintText: "Số nhà, Tên đường, Phường/Xã",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 3);
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: _controllerPhoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Số điện thoại",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: _controllerName,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Tên",
        hintText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  //address
  getDistrictList(int provinceId) {
    Province province = provinces
        .where((e) => e.code.toString().contains(provinceId.toString()))
        .first;
    setState(() {
      districts = province.districts;
    });
  }

  getNameProvince(int id) {
    Province province =
        provinces.where((e) => e.code.toString().contains(id.toString())).first;
    setState(() {
      provinceName = province.name;
    });
  }

  getNameDistrict(int id) {
    District district =
        districts.where((e) => e.code.toString().contains(id.toString())).first;
    setState(() {
      districtName = district.name;
    });
  }
}

class EditCustomerForm extends StatefulWidget {
  Customer customer;

  EditCustomerForm({super.key, required this.customer});

  @override
  State<EditCustomerForm> createState() => EditCustomerFormState();
}

class EditCustomerFormState extends State<EditCustomerForm> {
  SharedPref sharedPref = SharedPref();
  CustomerService customerService = CustomerService();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  Customer? customer;
  var provinceId = 0, districtId = 0, id = 0;
  String name = '', address = '', phone = '', accountUsername = '';
  bool isDefault = false;
  String provinceName = '', districtName = '';

  @override
  void initState() {
    getProvinces();
    loadUsername();
    loadData();
    setState(() {
      _controllerName.text = widget.customer.name ?? '';
      _controllerPhoneNumber.text = widget.customer.phone ?? '';
      _controllerAddress.text = widget.customer.address ?? '';
    });
    //getDistrictList(widget.customer.provinceId);
    super.initState();
  }

  loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accountUsername = prefs.getString('username')!;
    });
  }

  loadData() {
    setState(() {
      customer = widget.customer;
      id = customer!.id;
      phone = customer!.phone;
      name = customer!.name;
      address = customer!.address;
      provinceId = customer!.provinceId;
      districtId = customer!.districtId;
      isDefault = customer!.isDefault;
    });
  }

  //address
  Client client = Client();
  String host = "https://provinces.open-api.vn/api/?depth=2";
  var data;
  List<Province> provinces = [];
  List<District> districts = [];

  Future<void> getProvinces() async {
    final res = await client.get(
      Uri.parse(host),
      headers: {"content-type": "application/json; charset=UTF-8"},
    );
    if (res.statusCode == 200) {
      setState(() {
        data = jsonDecode(utf8.decode(res.bodyBytes));
        provinces = List<Province>.from(data.map((i) {
          return Province.fromJSON(i);
        }));
      });
    } else {
      print("Error during fetching data");
    }
  }

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void clearError() {
    setState(() {
      errors.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    getDistrictList(widget.customer.provinceId);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          const Text(
            "Địa chỉ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Column(
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: provinceId,
                    hint: const Text("Chọn Tỉnh/TP"),
                    onChanged: (int? value) {
                      setState(() {
                        provinceId = value!;
                        getNameProvince(value);
                      });
                      getDistrictList(value!);
                      districtId = districts.first.code;
                    },
                    items: provinces.map((p) {
                      return DropdownMenuItem(
                        value: p.code,
                        child: Text(p.name), //value of item
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: districtId,
                    hint: const Text("Chọn Quận/Huyện"),
                    items: districts.map((d) {
                      return DropdownMenuItem(
                        value: d.code,
                        child: Text(d.name), //value of item
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        districtId = value!;
                        getNameDistrict(value);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Cập nhật",
            press: () {
              String name = _controllerName.text.toString();
              String phone = _controllerPhoneNumber.text.toString();
              String address =
                  '${_controllerAddress.text}, $districtName, $provinceName';
              CustomerRequest customer = CustomerRequest(
                  name: name,
                  phone: phone,
                  address: address,
                  districtId: districtId,
                  provinceId: provinceId,
                  isDefault: isDefault,
                  accountUsername: accountUsername);
              clearError();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                print(customer.toString());
                customerService.putCustomer(customer, id).then((value) {
                  if (value == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (context) => ProfileScreen()),
                      (_) => false,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomersScreen()));
                  } else {
                    addError(error: "Thay đổi không thành công");
                    return "";
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        controller: _controllerAddress,
        onSaved: (newValue) => address = newValue!,
        onChanged: (value) {
          getNameProvince(provinceId);
          getNameDistrict(districtId);
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Địa chỉ",
          hintText: "Số nhà, Tên đường, Phường/Xã",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 3);
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: _controllerPhoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Số điện thoại",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: _controllerName,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Tên",
        hintText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  //address
  getDistrictList(int provinceId) {
    Province province = provinces
        .where((e) => e.code.toString().contains(provinceId.toString()))
        .first;
    setState(() {
      districts = province.districts;
    });
  }

  getNameProvince(int id) {
    Province province =
        provinces.where((e) => e.code.toString().contains(id.toString())).first;
    setState(() {
      provinceName = province.name;
    });
  }

  getNameDistrict(int id) {
    District district =
        districts.where((e) => e.code.toString().contains(id.toString())).first;
    setState(() {
      districtName = district.name;
    });
  }
}
