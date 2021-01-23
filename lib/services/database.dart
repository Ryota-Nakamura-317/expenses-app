import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection("expenses");

  Future updateUserData(String payment, String price, String createdAt) async {
    return await expensesCollection.doc(uid).set({
      'payment': payment,
      'price': price,
      'createdAt': createdAt,
    });
  }
}
