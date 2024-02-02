import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFunction {
  static Future<void> updateUserDocument(Map<String, String> question) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('questions').add(question);
  }
}
