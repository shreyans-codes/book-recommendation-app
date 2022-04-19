import 'dart:io';
import 'package:book_search/models/book_model.dart';
import 'package:book_search/services/brs-recommend-service.dart';
import 'package:book_search/services/retrieve-bookList.dart';
import 'package:http/http.dart' as http;
import 'package:book_search/services/retrieve-books.dart';
import 'package:get/get.dart';

class BrsController extends GetxController {
  List<BrsBook> bookList = [];
  var isLoading = true.obs;

  Future<String> fetchRecommendations(int index) async {
    try {
      String retVal = "error";
      isLoading(true);
      print("Knight Knight!");
      bookList = await getRecommendedBooks(index);
      if (bookList.isNotEmpty) retVal = "ok";
      print(bookList[1].title);
      return retVal;
    } finally {
      isLoading(false);
    }
  }
}
