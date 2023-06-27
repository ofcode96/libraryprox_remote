// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/logs_apis.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/models/logs_model.dart';

LogsApi logsApi = LogsApi();

class LogsServices {
  Future<List<Logs>> getAllLogs(BuildContext context) async {
    List<Logs> logs = [];

    Response response = await logsApi.getAll();
    var notValideData = jsonDecode(response.body) as List;

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        for (var log in notValideData) {
          logs.add(Logs.fromJson(jsonEncode(log)));
        }
      },
    );

    return logs;
  }

  Future log(Logs log, BuildContext context) async {
    Response response = await logsApi.addNew(log);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {},
    );
  }
}
