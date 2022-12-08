import 'package:codefactory_flutter/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) => 'http://$ip$value';

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}