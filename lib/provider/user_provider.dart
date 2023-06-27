import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/models/user_model.dart';

import '../common/helpers/shared_prefrences.dart';

class UserProvider extends ChangeNotifier {
  User _user =
      User(id: 0, username: "", password: "", isAdmin: false, token: "");

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void currentUser() async {
    _user = User.fromMap(jsonDecode(
        await SharedPrefrencesServices.getData<String>("currentUser")));
    notifyListeners();
  }
}
