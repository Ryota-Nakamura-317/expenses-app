import 'package:expenses_app/screens/add_edit/add_page.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:expenses_app/screens/home/home_model.dart';
import 'package:expenses_app/screens/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenChangePage extends StatelessWidget {
  final List<Widget> _pageList = <Widget>[
    HomePage(),
    TodoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel(),
      child: Scaffold(
        body: Consumer<HomePageModel>(builder: (context, model, child) {
          return Scaffold(
            body: _pageList[model.currentIndex],
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.blueGrey[700],
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPricePage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:
                Consumer<HomePageModel>(builder: (context, model, child) {
              return Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black54, blurRadius: 0.5)
                ]),
                child: BottomNavigationBar(
                  elevation: 20.0,
                  type: BottomNavigationBarType.shifting,
                  unselectedItemColor: Colors.grey,
                  fixedColor: Colors.blueGrey[600],
                  //backgroundColor: Colors.black,
                  currentIndex: model.currentIndex,
                  onTap: (index) {
                    model.currentIndex = index;
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: '支出',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Todo',
                      icon: Icon(Icons.format_list_bulleted),
                    ),
                  ],
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
