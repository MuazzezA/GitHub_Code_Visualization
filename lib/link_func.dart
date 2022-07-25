import 'dart:io';

import 'package:http/http.dart' as http;

// ad/proje/branch stringi geliyo

List<String> getTranslatedLinkAsList(String projectPath) {
  List<String> splitLink = projectPath.split("/");
  splitLink[0] = splitLink[0].trim();
  splitLink[1] = splitLink[1].trim();
  splitLink[2] = splitLink[2].trim();
  return splitLink;
}

Future<int> checkUrl(String projectPath) async {
  // ad / proje adı bitişik geldi

  http.Response response =
      await http.Client().get(Uri.parse("github.com/$projectPath"));

  if (response.statusCode == 200) {
    print("object 200");
    return 200;
  } else {
    return 301;
  }
}

Future<bool> checkPath(String projectPath) async {
  http.Response response =
      await http.Client().get(Uri.parse("github.com/$projectPath"));

  if (checkUrl(projectPath) == 200) {
    return true;
  } else if (checkUrl(projectPath) == 301) {
    return false; //empty
  } else {
    return false;
  }
}
