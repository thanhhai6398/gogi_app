import 'dart:convert';
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
import '../../../size_config.dart';

class CustomerFormScreen extends StatelessWidget {
  static String routeName = "/addOrUpdateCustomer";

  Widget build(BuildContext context) {
    final CustomerArguments args =
        ModalRoute.of(context)!.settings.arguments as CustomerArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(padding: EdgeInsets.all(20),child: CustomerForm(action: args.action),),
    );
  }
}

class CustomerForm extends StatefulWidget {
  // static String routeName = "/addOrUpdateCustomer";
  String action;

  CustomerForm({super.key, required this.action});

  @override
  State<CustomerForm> createState() => CustomerFormState();
}

class CustomerFormState extends State<CustomerForm> {
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
    if (widget.action != 'add') {
      final CustomerArguments args =
          ModalRoute.of(context)!.settings.arguments as CustomerArguments;
      _controllerName.text = args.customer.name;
      _controllerPhoneNumber.text = args.customer.phone;
      _controllerAddress.text = args.customer.address;

      getDistrictList(args.customer.provinceId);

      setState(() {
        id = args.customer.id;
        provinceValue = args.customer.provinceId;
        districtValue = args.customer.districtId;
      });


      provinceId = args.customer.provinceId;
      getNameProvince(args.customer.provinceId);
      districtId = args.customer.districtId;
      getNameDistrict(args.customer.districtId);
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Địa chỉ",
            textAlign: TextAlign.center,
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
                  child: DropdownButton(
                    isExpanded: true,
                    value: provinceValue,
                    hint: const Text("Chọn Tỉnh/TP"),
                    items: provinces.map((p) {
                      return DropdownMenuItem(
                        value: p.code,
                        child: Text(p.name), //value of item
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        provinceValue = value!;
                        provinceId = value;
                        getNameProvince(value);
                        districtValue = null;
                      });
                      getDistrictList(value!);
                    },
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
                    hint: const Text("Chọn Quận/ Huyện"),
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
              CustomerReq customer = CustomerReq(
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
                (widget.action != 'add') ? {
                  customerService.putCustomer(customer, id).then((value) {
                    if (value == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomersScreen()));
                    } else {
                      addError(error: "Thêm địa chỉ không thành công");
                      return "";
                    }
                  })
                } : {
                  customerService.postCustomer(customer).then((value) {
                    if (value == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomersScreen()));
                    } else {
                      addError(error: "Thêm địa chỉ không thành công");
                      return "";
                    }
                  })
                };

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
        hintText: "Địa chỉ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
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

class CustomerArguments {
  final Customer customer;
  final String action;

  CustomerArguments({required this.customer, required this.action});
}
