import 'package:expenses_app/screens/add_edit/add_page.dart';
import 'package:expenses_app/screens/add_edit/edit_page.dart';
import 'package:expenses_app/screens/home/home_model.dart';
import 'package:expenses_app/screens/signin_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel(),
      child: Consumer<HomePageModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              '支出管理',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                color: Colors.black,
                onPressed: () async {
                  await model.signOut();
                  //todo pushAndRemoveUntilに変更
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInSignUpPage(),
                    ),
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Consumer<HomePageModel>(builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    calendarController: model.calendarController,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      //markersColor: Colors.blueGrey,
                      todayColor: Colors.black,
                      selectedColor: Colors.grey,
                      todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: model.onDaySelected,
                    /*builders: CalendarBuilders(
                        markersBuilder: (context, date, events, holidays) {
                          final children = <Widget>[];
                          if (events.isNotEmpty) {
                            children.add(
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: _buildEventsMarker(date, events),
                              ),
                            );
                          }
                          return children;
                        },
                      ),*/
                  ),
                  Consumer<HomePageModel>(
                    builder: (context, model, child) {
                      final expensesList = model.expensesList;
                      final listTiles = expensesList
                          .map((expenses) => Card(
                                margin:
                                    EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.arrow_right,
                                    color: Colors.blueGrey,
                                  ),
                                  title: Text('${expenses.price}円'),
                                  subtitle: Text('${expenses.category}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            expenses: expenses,
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ))
                          .toList();
                      return ListView(
                        shrinkWrap: true,
                        children: listTiles,
                      );
                    },
                  ),
                ],
              ),
            );
          }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      }),
    );
  }
}
