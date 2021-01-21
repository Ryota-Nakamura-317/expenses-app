import 'package:expenses_app/screens/home/home2.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  //テキストフィールドに入力した内容の表示
  TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
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
          'rita',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home2()),
              );
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
              events: _events,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_outlined),
        backgroundColor: Colors.black,
        onPressed: _showAddDialog(),
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: [
          FlatButton(
            onPressed: () {
              setState(() {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [_eventController.text];
                }
              });
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }
}
