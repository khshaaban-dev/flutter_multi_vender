import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// this method handel errors if its exist or execute onSuccess method
void errorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context: context,
        message: getErrorMessages(
          jsonDecode(response.body),
        ),
      );
      break;
    case 500:
      showSnackBar(
          context: context, message: jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context: context, message: jsonDecode(response.body));
  }
}

String getErrorMessages(Map<String, dynamic> json) {
  String messages = '';
  if (json['message'] is List<dynamic>) {
    for (var e in (json['message'] as List<dynamic>)) {
      messages = '$messages${e['message'].toString()}\n ';
    }
    return messages;
  }
  messages = json['message'].toString();
  return messages;
}
