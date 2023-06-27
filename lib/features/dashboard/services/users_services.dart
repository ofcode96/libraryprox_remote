// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/models/user_model.dart';

import '../../../apis/user_apis.dart';

UserApi usersApi = UserApi();

class UsersServices {
  Future<List<User>> getAllUsers(BuildContext context, String? query) async {
    List<User> users = [];

    Response response = await usersApi.getAll();
    var notValideData = jsonDecode(response.body);

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        for (var user in notValideData) {
          users.add(User.fromJson(jsonEncode(user)));
        }
      },
    );

    if (query != null) {
      return users.where((user) {
        final searchResult =
            user.id.toString().toLowerCase().contains(query.toLowerCase()) ||
                user.username
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase());
        return searchResult;
      }).toList();
    }

    return users;
  }

  Future removeUser(int id, BuildContext context) async {
    Response response = await usersApi.delete(id);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        showSnackBar(context, "Deleted User ");
      },
    );
  }

  Future updateUser(int id, User user, BuildContext context) async {
    Response response = await usersApi.update(id, user);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Update User ");
      },
    );
  }

  Future addNewUser(User user, BuildContext context) async {
    Response response = await usersApi.addNew(user);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        showSnackBar(context, "Add User ");
      },
    );
  }
}
