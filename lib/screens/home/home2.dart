import 'package:expenses_app/screens/home/add_expenses.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final AuthService _auth = AuthService();
  CalendarController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 15.0,
        title: Text(
          'izumi',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.supervisor_account),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.black,
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                todayColor: Colors.black,
                selectedColor: Colors.grey[500],
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                  color: Colors.white,
                ),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
                formatButtonShowsNext: false,
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
      //支出の追加入力フォーム
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_outlined),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpenses(),
              ));
        },
      ),
    );
  }
}
