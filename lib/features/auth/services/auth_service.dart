import 'dart:convert';

import 'package:amazon_clone/constants/baseurl.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String signupUrl = "/api/signup";
  final String signinUrl = "/api/signin";
  final String tokenIsValid = "/api/tokenIsValid";

  // signup
  void signup({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        token: '',
      );

      final http.Response response = await http.post(
        Uri.parse(baseUrl + signupUrl),
        body: user.toJson(),
        headers: <String, String>{...GlobalVariables.contentTypeJson},
      );

      if (context.mounted) {
        errorHandling(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context, message: 'Your Account Has Created.');
          },
        );
      }
    } on Exception catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  // signin
  void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final user = User(
        id: '',
        name: '',
        email: email,
        password: password,
        address: '',
        token: '',
      );

      final http.Response response = await http.post(
        Uri.parse(baseUrl + signinUrl),
        body: user.toJson(),
        headers: <String, String>{...GlobalVariables.contentTypeJson},
      );

      if (context.mounted) {
        errorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            // add token to shared preferences
            if (context.mounted) {
              // change user Provider
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(response.body);
              // go to home page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
            }
          },
        );
      }
    } on Exception catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

// check if token is valid or not
  void getUserData(BuildContext context) async {
    try {
      final SharedPreferences ref = await SharedPreferences.getInstance();

      String? token = ref.getString(GlobalVariables.xAuthToken);
      if (token == null) {
        await ref.setString(GlobalVariables.xAuthToken, '');
      }

      // check is token valid
      var tokenRes = await http.post(
        Uri.parse('$baseUrl$tokenIsValid'),
        headers: <String, String>{
          GlobalVariables.xAuthToken: token!,
          ...GlobalVariables.contentTypeJson,
        },
      );

      final result = jsonDecode(tokenRes.body);
      // token is valid
      if (result == true) {
        // get user data
        final userData = await http.get(
          Uri.parse('$baseUrl/'),
          headers: <String, String>{
            GlobalVariables.xAuthToken: token,
            ...GlobalVariables.contentTypeJson,
          },
        );
        if (context.mounted) {
          Provider.of<UserProvider>(context, listen: false).setUser(
            userData.body,
          );
        }
      }
    } on Exception catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
