import 'package:expenses_app/model/expenses_data.dart';
import 'package:expenses_app/screens/home/expenses_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<List<ExpensesData>>(context) ?? [];

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpensesTile();
      },
    );
  }
}
