import 'dart:convert';

import 'dart:ffi';

class Books {
  String? title;
  String? author;
  var avgRating;
  int totalRating;
  String? imgUrl;

  Books(this.title, this.author, this.avgRating, this.totalRating, this.imgUrl);
}

Future<List<Books>> getBooksFromJson(String source) async {
  List<Books> books = [];
  String defImgLink =
      "https://images.unsplash.com/photo-1588666309990-d68f08e3d4a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80";
  String retVal = "error";
  Map<String, dynamic> jVal = jsonDecode(source);
  if (jVal['totalItems'] == 0) return books;
  var jValItem = jVal['items'];

  print(jValItem);
  String? title, author, imgUrl;
  var avgRating, totalRating;
  for (int i = 0; i < jValItem.length; i++) {
    var temp = jValItem[i]['volumeInfo'];
    if (temp['averageRating'] == null) continue;
    title = temp['title'] ?? "Title Unknown";
    author = temp['authors'][0] ?? "Author Unknown";
    avgRating = temp['averageRating'].toDouble();
    totalRating = temp['ratingsCount'] ?? 0;
    if (temp['imageLinks'] == null) {
      imgUrl = defImgLink;
    } else {
      imgUrl = temp['imageLinks']['thumbnail'] ?? defImgLink;
    }
    Books tBook = new Books(title, author, avgRating, totalRating, imgUrl);
    books.add(tBook);
  }
  if (books != null) retVal = "success";
  for (var i = 0; i < books.length; i++) {
    print("Title -> " + books[i].title.toString());
    print("Rating -> " + books[i].avgRating.toString());
    print("Rating Count -> " + books[i].totalRating.toString());
  }
  return books;
}
