import 'dart:convert';

import 'package:expenses_app/screens/home/expenses_list.dart';
import 'package:expenses_app/screens/home/home2.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  //テキストフィールドに入力した内容の表示
  TextEditingController _eventController;
  //ローカルにデータを保存
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString('events') ?? '{}')));
    });
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
                todayColor: Colors.blueGrey,
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
              onDaySelected: (date, events, holidays) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[500], shape: BoxShape.circle),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey, shape: BoxShape.circle),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map(
              (event) => ExpensesList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_outlined),
        backgroundColor: Colors.black,
        onPressed: _showAddDialog,
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
            child: Text('save'),
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              setState(() {
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [_eventController.text];
                }
                //SharedPreferencesを使ってStringの読み込み
                prefs.setString('events', json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
