import 'package:github_code_file/models/repo_files.dart';
import 'package:github_code_file/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

// JSON İLE İLGİLİ ŞEYLER GELECEK
// KODLARI ALMAK İÇİN BUNA LİNK GİRİŞİ OLMALI

Future<Object> getUserInfoResponse({required String userName}) async {
  var dio = Dio();
  final response = await dio.get('https://api.github.com/users/$userName');

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.toString()));
  } else {
    throw Exception('failed in fetchUser');
  }
}

// home page
// 'https://raw.githubusercontent.com/MuazzezA/Automata_Theory/main/MealyMachine/Main.java'
Future<String> getSourceCodeResponse({required String fullPath}) async {
  Response<dynamic> response;
  var dio = Dio();

  if (fullPath != null || fullPath.isNotEmpty) {
    final responseh = await http.Client()
        .get(Uri.parse('https://raw.githubusercontent.com/${fullPath}'));
    if (responseh.statusCode == 200) {
      return responseh.body;
    } else {
      return "select code file";
    }
  } else {
    return "null path";
    //  MAİN KODU GETİRİLECEK
  }
}

Future<List<RepoInside>> fetchRepoInsideTree(
    {required String nickAndProjectName, required String branch}) async {
  branch = branch.split("/")[1];
  final response = await http.get(Uri.parse(
      'https://api.github.com/repos/${nickAndProjectName}/git/trees/${branch}?recursive=1'));
  print(
      "https://api.github.com/repos/${nickAndProjectName}/git/trees/${branch}?recursive=1");
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)[
        'tree']; // buraya tree koyarak direkt (tree)içine eriştik
    return jsonResponse.map((e) => RepoInside.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load fetchRepoInsideTree from API');
  }
}
