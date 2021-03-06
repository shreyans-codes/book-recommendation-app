import 'package:book_search/controller/bookList_controller.dart';
import 'package:book_search/controller/brs_controller.dart';
import 'package:book_search/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrsHome extends StatelessWidget {
  const BrsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookListController bookListController = Get.put(BookListController());
    final BrsController brsController = Get.put(BrsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Container(
          height: 38,
          child: TextField(
            onSubmitted: (value) async {
              value.replaceAll(" ", "+");
              value.toLowerCase();
              String kVal = await bookListController.booksFromJsonFile();
              // String val =
              //     await brsController.fetchRecommendations(int.parse(value));
              print(value);
            },
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.amber,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Enter Index"),
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Obx(
          () {
            if (brsController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: brsController.bookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (brsController.bookList.isEmpty) {
                      return const Center(
                        child: Text("Please enter a search term"),
                      );
                    } else {
                      return BrsBookCard(book: brsController.bookList[index]);
                      // return Text(
                      //     searchController.bookList[index].title.toString());
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BrsBookCard extends StatelessWidget {
  const BrsBookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BrsBook book;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  book.imgUrl.toString(),
                ),
                Text(
                  book.title.toString(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Author = " + book.author.toString(),
                  style: subStyles,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle subStyles = TextStyle(color: Colors.amber);
