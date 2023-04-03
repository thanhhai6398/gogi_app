import 'package:flutter/material.dart';
import 'package:gogi/components/custom_surfix_icon.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/components/form_error.dart';
import 'package:gogi/models/Store.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CustomerProfileForm extends StatefulWidget {
  const CustomerProfileForm({super.key});

  @override
  _CustomerProfileFormState createState() => _CustomerProfileFormState();
}

class _CustomerProfileFormState extends State<CustomerProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? name;
  String? address;
  String? phoneNumber;
  int? dropdownValue = 1;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStoreFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Đặt hàng",
            press: () {},
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
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

  InputDecorator buildStoreFormField() {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        labelText: 'Cửa hàng',
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: demoStores.map((store) {
            return DropdownMenuItem<int>(
              value: store.id,
              child: Text(store.name),
            );
          }).toList(),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
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
}
