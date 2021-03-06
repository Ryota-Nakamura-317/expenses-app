import 'package:expenses_app/screens/add_edit/edit_page.dart';
import 'package:expenses_app/screens/home/home_model.dart';
import 'package:expenses_app/screens/signin_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final modelData = Provider.of<HomePageModel>(context, listen: true);
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel()..getTotalPrice(),
      child: Consumer<HomePageModel>(builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.blueGrey,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                '当月合計：${model.totalPrice}円',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700],
                ),
              ),
              actions: [
                IconButton(
                  color: Colors.blueGrey,
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    calendarController: model.calendarController,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.black,
                      selectedColor: Colors.blueGrey,
                      todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: model.onDaySelected,
                  ),
                  ListView(
                      controller: model.scrollController,
                      shrinkWrap: true,
                      children: model.expensesList
                          .map(
                            (expenses) => Card(
                              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.arrow_right,
                                  color: Colors.cyan[900],
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
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('詳細'),
                                        content: Container(
                                          width: 500.0,
                                          height: 450.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(
                                                          Icons.attach_money),
                                                      title: StyledText(
                                                          text:
                                                              '金額：<bold>${expenses.price} 円</bold>',
                                                          styles: {
                                                            'bold': TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                          }),
                                                    ),
                                                    Divider(
                                                        color: Colors.blueGrey),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.payment),
                                                      title: StyledText(
                                                          text:
                                                              '支払い方法：<bold>${expenses.payments}</bold>',
                                                          styles: {
                                                            'bold': TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                          }),
                                                    ),
                                                    Divider(
                                                        color: Colors.blueGrey),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.category),
                                                      title: StyledText(
                                                          text:
                                                              'カテゴリ：<bold>${expenses.category}</bold>',
                                                          styles: {
                                                            'bold': TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                          }),
                                                    ),
                                                    Divider(
                                                        color: Colors.blueGrey),
                                                    ListTile(
                                                      leading: Icon(
                                                          Icons.calendar_today),
                                                      title: StyledText(
                                                          text:
                                                              '日付：<bold>${model.formatter.format(expenses.date.toDate())}</bold>',
                                                          styles: {
                                                            'bold': TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                          }),
                                                    ),
                                                    Divider(
                                                        color: Colors.blueGrey),
                                                    ListTile(
                                                      leading: Icon(
                                                          Icons.text_fields),
                                                      title: StyledText(
                                                          text:
                                                              'メモ：<bold>${expenses.memo}</bold>',
                                                          styles: {
                                                            'bold': TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                          }),
                                                    ),
                                                    SizedBox(height: 40.0),
                                                  ],
                                                ),
                                              ),
                                              RaisedButton(
                                                child: Text('戻る'),
                                                textColor: Colors.white,
                                                color: Colors.blueGrey,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                          .toList()),
                ],
              ),
            ));
      }),
    );
  }
}
