import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '支出総額',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 10.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Text('date'),
        ],
      ),
    );
    /*return ChangeNotifierProvider<ChartModel>(
      create: (_) => ChartModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '支出総額',
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 10.0,
          backgroundColor: Colors.white,
        ),
        body: Consumer<ChartModel>(builder: (context, model, child) {
          return Column();
        }),
      ),
    );*/
  }
}
