import 'package:flutter/material.dart';

class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 15.0,
        title: Text(
          'rita',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(),
            RaisedButton(
              color: Colors.black,
              child: Text(
                '追加',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
