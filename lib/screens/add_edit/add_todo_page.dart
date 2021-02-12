import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/todo_data.dart';
import 'package:expenses_app/screens/add_edit/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  final TodoData todoData;
  AddTodoPage({this.todoData});
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    //アップデートの判断

    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo追加',
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
        body: Consumer<AddModel>(builder: (context, model, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      cursorColor: Colors.blueGrey,
                      name: 'newTodoText',
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'やること',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return '入力してください。';
                        }
                        return null;
                      },
                      onChanged: (String newTodoText) {
                        model.newTodoText = newTodoText;
                      },
                    ),
                    Divider(),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      textInputAction: TextInputAction.next,
                      initialDate: DateTime.now(),
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      decoration: InputDecoration(
                        hintText: 'いつまでに？',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (DateTime dateTime) {
                        if (dateTime == null) {
                          return '日付が未入力です。';
                        }
                        return null;
                      },
                      //DateTime型からTimeStamp型にしてdateに代入
                      onChanged: (DateTime date) {
                        if (date != null) {
                          model.date = Timestamp.fromDate(date);
                        } else {
                          return null;
                        }
                      },
                    ),
                    Divider(),
                    SizedBox(height: 50.0),
                    RaisedButton(
                      child: Text('追加'),
                      textColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          await model.addTodo(todoData);
                          //todo 処理
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
