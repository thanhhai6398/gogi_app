import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

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
                  "Contact us",
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

class ContactForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Form (
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Your name'),
                hintText: 'Enter your name...',
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
              //Do something with this value
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text("Your email"),
                hintText: 'Enter your email...',
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
              //Do something with this value
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Comment:'),
                hintText: 'Enter your comment...',
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
              //Do something with this value
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Send",
            press: () {},
          ),
        ],
    ),

    );
  }
}
