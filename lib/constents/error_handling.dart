import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/constents/utils.dart';

void httpErrorHandler(
    {required Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) async {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 401:
      showSnackBar(context, jsonDecode(response.body)["detail"]);
      break;
    case 404:
      showSnackBar(context, jsonDecode(response.body)["detail"]);
      break;
    case 500:
      showSnackBar(context, 'Something has gone wrong , just try again  ');
      break;
    default:
      showSnackBar(context, 'Server Error ');
  }
}
