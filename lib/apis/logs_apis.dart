import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/models/logs_model.dart';

import '../common/helpers/ip_handler.dart';
import 'package:http/http.dart' as client;

class LogsApi {
  Future<client.Response> getAll() async {
    Uri uri = await IpHandler.api(endPoint: "log");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }

  Future<client.Response> addNew(Logs log) async {
    Uri uri = await IpHandler.api(
        endPoint: "log", queryParams: {"msg": log.opration, "user": log.user});
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.post(
      uri,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }
}
