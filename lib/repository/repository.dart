import 'dart:convert';

import 'package:http/http.dart';

import '../models/persons.dart';

class Repository {
  String url = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';
  Future<List<Persons>> getDataList() async {
    Response resp = await get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final List result = jsonDecode(resp.body);
      print(url);
      print(resp);
      return result.map((e) => Persons.fromJson(e)).toList();
    } else {
      throw Exception(resp.reasonPhrase);
    }
  }
}
