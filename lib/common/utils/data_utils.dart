import 'dart:convert';

import 'package:codefactory_flutter/common/const/data.dart';

class DataUtils {
  static DateTime stringToDateTime(String value) => DateTime.parse(value);

  static String pathToUrl(String value) => 'http://$ip$value';

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final encoded = stringToBase64.encode(plain);
    return encoded;
  }
}