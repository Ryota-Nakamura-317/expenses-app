import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';

class ExpensesTile extends StatelessWidget {
  final ExpensesData expenses;
  ExpensesTile({this.expenses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text('￥${expenses.price}'),
          subtitle: Text(expenses.payment),
        ),
      ),
    );
  }
}
