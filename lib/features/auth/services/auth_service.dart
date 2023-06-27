// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/user_apis.dart';
import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/features/dashboard/screens/home_screen.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  UserApi userApi = UserApi();

  login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    Response response =
        await userApi.login(username: username, password: password);

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        showSnackBar(context, "Login Success");

        // Save Token in storage
        await SharedPrefrencesServices.storeData(
            "token", jsonDecode(response.body)["access_token"]);

        // Get Me Current User
        Response me = await userApi.getMe();
        await SharedPrefrencesServices.storeData("currentUser", me.body);

        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUser(me.body);
        userProvider.currentUser();

        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routerName,
          (route) => false,
        );
      },
    );
  }

  loginQr(BuildContext context, String ip, String token) async {
    if (ip.isEmpty || token.isEmpty) return;
    // Save Token in storage
    await SharedPrefrencesServices.storeData("token", token);
// Save IP in storage
    await SharedPrefrencesServices.storeData("IP", ip);

    // Get Me Current User
    Response me = await userApi.getMe();
    await SharedPrefrencesServices.storeData("currentUser", me.body);

    var userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.setUser(me.body);
    userProvider.currentUser();

    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.routerName,
      (route) => false,
    );
  }
}
