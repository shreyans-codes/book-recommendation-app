import 'dart:convert';
import 'package:book_search/services/retrieve-bookList.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BookListController extends GetxController {
  List<BackendBook> bookList = [];
  List<String> searchableBookList = [];
  var isLoading = true.obs;

  Future<String> booksFromJsonFile() async {
    bookList = [];
    searchableBookList = [];
    final String response = await rootBundle.loadString('./assets/data.json');
    var data = await json.decode(response);
    String retVal = "error";
    retVal = "ok";
    for (int i = 0; i < data.length; i++) {
      BackendBook tempBook = BackendBook(id: i, name: data[i.toString()]);
      searchableBookList.add(tempBook.name.toString());
      bookList.add(tempBook);
    }
    print(bookList.length);
    print(bookList[40].name);
    return retVal;
  }

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
