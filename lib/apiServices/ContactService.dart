import 'dart:convert';
import 'dart:io';
import 'package:gogi/models/Request/FeedbackRequest.dart';
import 'package:http/http.dart' show Client;
import '../SharedPref.dart';
import '../constants.dart';

class ContactService {
  Client client = Client();

  Future<bool> login(FeedbackRequest payload) async {
    final response = await client.post(Uri.parse("$url/sendFeedback"),
        headers: {
          "content-type": "application/json; charset=UTF-8",
        },
        body: feedbackRequestToJson(payload));
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }
}
