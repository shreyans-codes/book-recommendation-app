import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:book_search/services/retrieve-books.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  List<Books> bookList = [];
  var isLoading = true.obs;

  Future<String> getJson(String query) async {
    query.replaceAll(" ", "+");
    final String baseUrl =
        "https://www.googleapis.com/books/v1/volumes?q=" + query;
    var response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    // try {
    //   final response = await http.get(Uri.parse(baseUrl));
    // } on SocketException {
    //   response = "error";
    //   throw Exception("No internet Connection!");
    // }
    return response.body.toString();
  }

  Future<String> fetchBooks(String query) async {
    try {
      String retVal = "error";
      isLoading(true);
      print("Moonlight!");
      String response = await getJson(query);
      bookList = await getBooksFromJson(response);
      if (bookList.isNotEmpty) retVal = "ok";
      return retVal;
    } finally {
      isLoading(false);
    }
  }
}
