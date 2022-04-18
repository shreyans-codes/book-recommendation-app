import 'package:book_search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:book_search/services/retrieve-books.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: MaterialApp(
        home: MyApp(),
        themeMode: ThemeMode.dark,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());
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
              String val = await searchController.fetchBooks(value.toString());
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
                hintText: "Search books"),
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Obx(
          () {
            if (searchController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: searchController.bookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (searchController.bookList.isEmpty) {
                      return const Center(
                        child: Text("Please enter a search term"),
                      );
                    } else {
                      return BookCard(book: searchController.bookList[index]);
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

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Books book;

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
                Text(
                  "Average Rating = " + book.avgRating.toString(),
                  style: subStyles.copyWith(color: Colors.blue),
                ),
                Text(
                  "Ratings Count = " + book.totalRating.toString(),
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
