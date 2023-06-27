import 'package:http/http.dart' as client;

class TestApi {
  static Future<client.Response> test(String currentIp) async {
    Uri uri = Uri.parse("http://$currentIp:9000/api");

    client.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
    });

    return response;
  }
}
