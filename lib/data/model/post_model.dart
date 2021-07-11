import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String title;
  DateTime dateTime;
  DocumentReference? _authorReference;
  String authorName;
  int numberOfLikes;
  int numberOfComments;
  String imageUrl;

  PostModel({
    required this.title,
    required this.dateTime,
    required this.authorName,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.imageUrl,
  });

  PostModel.fromMap(Map<String, dynamic>? map)
      : title = map?['title'] ?? '',
        dateTime = DateTime.fromMillisecondsSinceEpoch(
          (map?['dateTime'] as Timestamp).millisecondsSinceEpoch,
        ),
        _authorReference = map?['authorReference'],
        authorName = map?['authorName'],
        numberOfLikes = map?['numberOfLikes'],
        numberOfComments = map?['numberOfComments'],
        imageUrl = map?['imageUrl'] ?? '';

  toMap() => {
        'title': title,
        'dateTime': dateTime,
        'authorName': authorName,
        'numberOfLikes': numberOfLikes,
        'numberOfComments': numberOfComments,
        'imageUrl': imageUrl
      };
}
