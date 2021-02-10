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
            bottomNavigationBar:
                Consumer<HomePageModel>(builder: (context, model, child) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                unselectedItemColor: Colors.grey,
                fixedColor: Colors.blueGrey,
                backgroundColor: Colors.white,
                currentIndex: model.currentIndex,
                onTap: (index) {
                  model.currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: '支出',
                  ),
                  BottomNavigationBarItem(
                    label: 'Todo',
                    icon: Icon(Icons.format_list_bulleted),
                  ),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
