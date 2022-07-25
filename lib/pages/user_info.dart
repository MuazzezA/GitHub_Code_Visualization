// SİLİNCEK, BURDAKİ YAPI JSON SERVİCE.DART SAYFASINDA VAR

import 'package:github_code_file/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late Future<User> _userInfo;
  late User user;
  @override
  void initState() {
    super.initState();

    _userInfo = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USER INFO - http and dio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Flexible(
            child: Row(children: [
              getUserInfo(),
              const SizedBox(width: 50),
              getInfowithDio(),
            ]),
          ),
        ),
      ),
    );
  }

  FutureBuilder getUserInfo() {
    return FutureBuilder<User>(
        future: _userInfo,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(snapshot.data!.avatarUrl!),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("user name : " +
                          snapshot.data!
                              .userName!), //user.userName şeklinde erişilebilir
                      Text("user nick : " + snapshot.data!.login!),
                      Text("repo count : ${snapshot.data!.publicRepoCount!}"),
                    ]),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("ups! user info - küçük bir hata var"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<User> fetchUser() async {
    final response =
        await http.get(Uri.parse('https://api.github.com/users/MuazzezA'));

    if (response.statusCode == 200) {
      setState(() {
        user = User.fromJson(json.decode(response.body));
      });
      return user; // user.userName artık erişilebilir
    } else {
      throw Exception('failed in fetchUser');
    }
  }

  FutureBuilder getInfowithDio() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                foregroundImage: NetworkImage(snapshot.data!.avatarUrl!),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("user name : " +
                        snapshot.data!
                            .userName!), //user.userName şeklinde erişilebilir
                    Text("user nick : " + snapshot.data!.login!),
                    Text("repo count : ${snapshot.data!.publicRepoCount!}"),
                  ]),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("ups! küçük bir hata var"));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: getResponse(),
    );
  }

  Future<Object> getResponse() async {
    var dio = Dio();

    final response = await dio.get('https://api.github.com/users/MuazzezA');

    if (response.statusCode == 200) {
      setState(() {
        user = User.fromJson(json.decode(response.toString()));
      });
      return user;
    } else {
      throw Exception('failed in fetchUser');
    }
  }
}
