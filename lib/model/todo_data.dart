import 'package:cloud_firestore/cloud_firestore.dart';

class TodoData {
  String uid;
  String title;
  String documentId;
  Timestamp createdAt;
  Timestamp date;
  bool isDone = false;
  DocumentReference documentReference;

  TodoData(DocumentSnapshot doc) {
    this.uid = doc.data()['uid'];
    this.title = doc.data()['title'];
    this.documentId = doc.id;
    this.date = doc.data()['date'];
    this.createdAt = doc.data()['createdAt'];
    this.documentReference = doc.reference;
  }
}
