import 'package:book_search/controller/bookList_controller.dart';
import 'package:book_search/controller/brs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrsHome extends StatelessWidget {
  const BrsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookListController bookListController = Get.put(BookListController());
    final BrsController brsController = Get.put(BrsController());
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            bookListController.fetchBooks();
            // brsController.fetchRecommendations(51);
          },
          child: const Text("Retrieve Books"),
        ),
      ),
    );
  }
}
