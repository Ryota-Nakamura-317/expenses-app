import 'package:expenses_app/screens/home/add_expenses.dart';
import 'package:expenses_app/screens/home/home2.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = List.generate(10, (index) {
    var now = DateTime.now();
    var date = DateTime(now.year, now.month + index, now.day);
    String dateDisplay = DateFormat('yMMM').format(date);
    return Tab(text: dateDisplay);
  });

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

//class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

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
          //相方の支出リストへ移動
          IconButton(
            icon: Icon(Icons.supervisor_account),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home2(),
                  ));
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
        bottom: TabBar(
          isScrollable: true,
          tabs: tabs,
          labelColor: Colors.black,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 8.0,
          ),
          indicator: DotIndicator(
            color: Colors.black,
            distanceFromCenter: 16,
            radius: 3,
            paintingStyle: PaintingStyle.fill,
          ),
        ),
      ),

      //
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((tab) {
          return _createTab(tab);
        }).toList(),
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

  Widget _createTab(Tab tab) {
    return Center(
      child: Text('リスト'),
    );
  }
}
