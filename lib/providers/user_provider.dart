import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    token: '',
  );

  User get user => _user;

  void setUser(String stringUser) {
    _user = User.fromJson(stringUser);
    notifyListeners();
  }



  
}
