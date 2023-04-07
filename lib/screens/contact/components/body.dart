import 'package:flutter/material.dart';
import 'package:gogi/models/Request/FeedbackRequest.dart';

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

class ContactForm extends StatefulWidget {
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  FeedbackRequest feedback =FeedbackRequest(fullName: '', email: '', content: '');
  late String fullName, email, content;
  @override
  Widget build(BuildContext context) {
    return Form (
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Tên'),
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
              fullName = value;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text("Email"),
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
             email = value;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Nhận xét:'),
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
              content = value;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Gửi",
            press: () {
              feedback = FeedbackRequest(fullName: fullName, email: email, content: content);

            },
          ),
        ],
    ),
    );
  }
}
