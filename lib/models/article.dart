import 'dart:convert';

class Article {
  final String title;
  final String author;
  final String body;
  final String heading;
  final String image;

  Article({
    required this.title,
    required this.author,
    required this.body,
    required this.heading,
    required this.image,
  });

  // Convert an Article object into a Map. Useful for encoding to JSON or storing in databases.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'body': body,
      'heading': heading,
      'image': image,
    };
  }

  // Convert a Map into an Article object. Useful for decoding from JSON or databases.
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'],
      author: map['author'],
      body: map['body'],
      heading: map['heading'],
      image: map['image'],
    );
  }

  // Convert an Article object into a JSON string. Useful for network transmission.
  String toJson() => json.encode(toMap());

  // Convert a JSON string into an Article object. Useful for network reception.
  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));
}
