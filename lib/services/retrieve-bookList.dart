import 'dart:io';

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendBook {
  int? id;
  String? name;
  BackendBook({this.id, this.name});
}

Future<List<BackendBook>> getBookList() async {
  List<BackendBook> backendBook = [];
  final Map<String, String> httpHeaders = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };
  final String baseUrl = "http://10.0.2.2:5000/";
  var response =
      await http.post(Uri.parse(baseUrl + "brs/0"), headers: httpHeaders);
  if (response.statusCode == 200) {
    Map<String, dynamic> jVal = jsonDecode(response.body.toString());
    for (int i = 0; i < jVal.length; i++) {
      BackendBook tempBook = BackendBook(id: i + 1, name: jVal[i.toString()]);
      backendBook.add(tempBook);
    }
  } else {
    BackendBook tempBook = BackendBook(id: 0, name: "Error encountered");
    backendBook.add(tempBook);
  }
  return backendBook;
}
