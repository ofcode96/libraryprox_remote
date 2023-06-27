import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/models/borrow_model.dart';

import '../common/helpers/ip_handler.dart';
import 'package:http/http.dart' as client;

class BorrowsApi {
  Future<client.Response> getAll() async {
    Uri uri = await IpHandler.api(endPoint: "borrows");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }

  Future<client.Response> getOneById(int id) async {
    Uri uri = await IpHandler.api(endPoint: "borrows/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<client.Response> getOneByTitle(String title) async {
    Uri uri = await IpHandler.api(endPoint: "borrows/$title");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<client.Response> addNew(Borrow borrow) async {
    Uri uri = await IpHandler.api(endPoint: "borrows");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.post(uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: borrow.toJson());
    return response;
  }

  Future<client.Response> update(int id, Borrow borrow) async {
    Uri uri = await IpHandler.api(endPoint: "borrows/$id");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.put(
      uri,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: borrow.toJson(),
    );
    return response;
  }

  Future<client.Response> delete(int id) async {
    Uri uri = await IpHandler.api(endPoint: "borrows/$id");
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

  Future<client.Response> getStatstics() async {
    Uri uri = await IpHandler.api(endPoint: "borrows/data/statstics");
    String token = await SharedPrefrencesServices.getData<String>("token");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
  }
}
