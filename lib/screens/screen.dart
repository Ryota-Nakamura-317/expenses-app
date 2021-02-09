import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:expenses_app/screens/chart/chart_page.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:expenses_app/screens/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenChangePage extends StatelessWidget {
  final List<Widget> _pageList = <Widget>[
    HomePage(),
    ChartPage(),
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
              return BubbleBottomBar(
                opacity: .2,
                currentIndex: model.currentIndex,
                onTap: (index) {
                  model.currentIndex = index;
                },
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                elevation: 10.0,
                hasNotch: true, //new
                hasInk: true, //new, gives a cute ink effect
                inkColor: Colors
                    .black12, //optional, uses theme color if not specified
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                      backgroundColor: Colors.blueGrey,
                      icon: Icon(
                        Icons.house,
                        color: Colors.black,
                      ),
                      activeIcon: Icon(
                        Icons.house,
                        color: Colors.blueGrey,
                      ),
                      title: Text("Home")),
                  BubbleBottomBarItem(
                      backgroundColor: Colors.purple,
                      icon: Icon(
                        Icons.bar_chart,
                        color: Colors.black,
                      ),
                      activeIcon: Icon(
                        Icons.bar_chart,
                        color: Colors.purple,
                      ),
                      title: Text("Logs")),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
