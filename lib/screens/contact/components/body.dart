import 'package:flutter/material.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/models/Request/ContactRequest.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../contact_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Liên hệ chúng tôi",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                ContactForm(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget{
  @override
  State<ContactForm> createState() => StateContactForm();

}

class StateContactForm extends State<ContactForm>{
  AccountService accountService = AccountService();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? content;

  bool remember = false;
  late final List<String?> errors = [];

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
    return Form (
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildContentFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Gửi",
            press: () {
              String name = _controllerName.text.toString();
              String email = _controllerEmail.text.toString();
              String content = _controllerContent.text.toString();

              ContactRequest contactReq = ContactRequest(fullname: name, email: email, content: content);

              clearError();

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                accountService.postContact(contactReq).then((value) {
                  if(value == true) {
                    Navigator.pushNamed(context, ContactScreen.routeName);
                  }
                  else {}
                });
              }
            },
          ),
        ],
    ),

    );
  }
  TextFormField buildNameFormField() {
    return TextFormField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          label: const Text('Tên'),
          hintText: 'Tên của bạn...',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          )
      ),
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
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          label: const Text("Email"),
          hintText: 'Email của bạn...',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          )
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
    );
  }
  TextFormField buildContentFormField() {
    return TextFormField(
      controller: _controllerContent,
      maxLines: null,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          label: const Text('Nhận xét:'),
          hintText: 'Hãy gửi feedback cho chúng tôi...',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32.0),
              borderRadius: BorderRadius.circular(5.0)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
          )
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kContentNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kContentNullError);
          return "";
        }
        return null;
      },
    );
  }
}
