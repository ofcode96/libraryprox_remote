import 'package:http/http.dart' as client;
import 'package:libraryprox_remote/common/helpers/ip_handler.dart';
import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/models/user_model.dart';

class UserApi {
  Future<client.Response> login(
      {required String username, required String password}) async {
    Uri uri = await IpHandler.api(endPoint: "token");

    client.Response response = await client.post(uri,
        headers: <String, String>{
          "Content-type": "application/x-www-form-urlencoded"
        },
        body:
            "grant_type=&username=$username&password=$password&scope=&client_id=&client_secret=");

    return response;
  }

  Future<client.Response> getMe() async {
    Uri uri = await IpHandler.api(endPoint: "users/me");
    String token = await SharedPrefrencesServices.getData<String>("token");
    client.Response response = await client.get(
      uri,
      headers: <String, String>{
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }

  getUser() async {
    Uri uri = await IpHandler.api();
    client.get(uri);
  }

  Future<client.Response> getAll() async {
    Uri uri = await IpHandler.api(endPoint: "users");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }

  Future<client.Response> getOneById(int id) async {
    Uri uri = await IpHandler.api(endPoint: "users/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<client.Response> addNew(User user) async {
    Uri uri = await IpHandler.api(endPoint: "users");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.post(uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: user.toJson());
    return response;
  }

  Future<client.Response> update(int id, User user) async {
    Uri uri = await IpHandler.api(endPoint: "users/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.put(
      uri,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: user.toJson(),
    );
    return response;
  }

  Future<client.Response> delete(int id) async {
    Uri uri = await IpHandler.api(endPoint: "users/$id");
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
