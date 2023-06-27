import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';

class IpHandler {
  static Future<void>? init() async {
    await address();
  }

  static Future<String> address() async {
    final String ip = await SharedPrefrencesServices.getData<String>("IP");
    return "http://$ip:9000";
  }

  static Future<Uri> api(
      {String? endPoint, Map<String, dynamic>? queryParams}) async {
    final addressScheme = await address();
    Uri uri = Uri.parse("$addressScheme/api/v1/$endPoint");
    if (queryParams == null) {
      return uri;
    }
    return uri.replace(queryParameters: queryParams);
  }

  static Future<Uri> test() async {
    final addressScheme = await address();
    Uri uri = Uri.parse("$addressScheme/api/");

    return uri;
  }
}
