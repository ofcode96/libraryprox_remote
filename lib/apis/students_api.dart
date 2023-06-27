import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/models/student_model.dart';

import '../common/helpers/ip_handler.dart';
import 'package:http/http.dart' as client;

class StudentsApi {
  Future<client.Response> getAll() async {
    Uri uri = await IpHandler.api(endPoint: "students");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }

  Future<client.Response> getOneById(int id) async {
    Uri uri = await IpHandler.api(endPoint: "students/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<client.Response> getOneByTitle(String title) async {
    Uri uri = await IpHandler.api(endPoint: "students/$title");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<client.Response> addNew(Students student) async {
    Uri uri = await IpHandler.api(endPoint: "students");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.post(uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: student.toJson());
    return response;
  }

  Future<client.Response> update(int id, Students student) async {
    Uri uri = await IpHandler.api(endPoint: "students/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.put(
      uri,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: student.toJson(),
    );
    return response;
  }

  Future<client.Response> delete(int id) async {
    Uri uri = await IpHandler.api(endPoint: "students/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.delete(
      uri,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }
}
