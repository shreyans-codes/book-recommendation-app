import 'dart:io';
import 'package:book_search/services/retrieve-bookList.dart';
import 'package:http/http.dart' as http;
import 'package:book_search/services/retrieve-books.dart';
import 'package:get/get.dart';

class BookListController extends GetxController {
  List<BackendBook> bookList = [];
  var isLoading = true.obs;

  Future<String> fetchBooks() async {
    try {
      String retVal = "error";
      isLoading(true);
      print("Knight Knight!");
      bookList = await getBookList();
      if (bookList.isNotEmpty) retVal = "ok";
      print(bookList[34].name);
      return retVal;
    } finally {
      isLoading(false);
    }
  }
}
