import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:book_search/models/book_model.dart';

Future<List<BrsBook>> getRecommendedBooks(int index) async {
  List<BrsBook> recommendedBooks = [];
  String defImgLink =
      "https://images.unsplash.com/photo-1588666309990-d68f08e3d4a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80";
  final Map<String, String> httpHeaders = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };
  final String baseUrl = "http://10.0.2.2:5000/";
  var response =
      await http.get(Uri.parse(baseUrl + "brs/$index"), headers: httpHeaders);
  if (response.statusCode == 200) {
    Map<String, dynamic> jVal = jsonDecode(response.body.toString());
    print(jVal["0"]);
    for (int i = 0; i < jVal.length; i++) {
      // var tempJson = jVal[i][''];W
      BrsBook tempBook = BrsBook();
      tempBook.id = i;
      tempBook.author = jVal[i.toString()]['author'];
      tempBook.title = jVal[i.toString()]['title'];
      tempBook.imgUrl = jVal[i.toString()]['imgUrl'] ?? defImgLink;
      recommendedBooks.add(tempBook);
    }
  } else {
    BrsBook tempBook = BrsBook();
    tempBook.id = 0;
    tempBook.author = "Author Unknown";
    tempBook.title = "Error Encountered";
    tempBook.imgUrl = defImgLink;
    recommendedBooks.add(tempBook);
  }
  return recommendedBooks;
}
