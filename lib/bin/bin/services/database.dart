/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/bin/model/model/expenses_data.dart';

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

  List<ExpensesData> _expensesListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExpensesData(
        payment: doc.data()['payment'] ?? '0',
        price: doc.data()['price'] ?? '0',
        createdAt: doc.data()['createdAt'] ?? '',
      );
    }).toList();
  }

  Stream<List<ExpensesData>> get expenses {
    return expensesCollection.snapshots().map(_expensesListFormSnapshot);
  }
}
*/
