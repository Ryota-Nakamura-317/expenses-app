import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/home/add_model.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  final Expenses expenses;
  EditPage({this.expenses});
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("ja_JP");
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '支出編集',
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
                      initialValue: expenses.price,
                      cursorColor: Colors.blueGrey,
                      name: 'price',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '金額',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onSaved: (String price) {
                        model.price = price;
                      },
                    ),
                    Divider(),
                    FormBuilderDropdown(
                      initialValue: expenses.payments,
                      name: 'payments',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.payment),
                        border: InputBorder.none,
                      ),
                      allowClear: true,
                      hint: Text('支払い方法'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      items: model.payment
                          .map((payment) => DropdownMenuItem(
                                value: payment,
                                child: Text('$payment'),
                              ))
                          .toList(),
                      onSaved: (String payments) {
                        model.payments = payments;
                      },
                    ),
                    Divider(),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      currentDate: expenses.date.toDate(),
                      initialValue: expenses.date.toDate(),
                      initialDate: expenses.date.toDate(),
                      inputType: InputType.date,
                      format: DateFormat('yyyy/MM/dd(E) ', "ja_JP"),
                      decoration: InputDecoration(
                        hintText: 'タップして日付を選択',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      //DateTime型からTimeStamp型にしてdateに代入
                      onSaved: (DateTime date) {
                        if (date != null) {
                          model.date = Timestamp.fromDate(date);
                        } else {
                          model.date = expenses.date;
                        }
                      },
                    ),
                    Divider(),
                    FormBuilderTextField(
                      initialValue: expenses.memo,
                      cursorColor: Colors.blueGrey,
                      name: 'メモ',
                      maxLines: 20,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メモ',
                        prefixIcon: Icon(Icons.text_fields),
                      ),
                      onSaved: (String memo) {
                        model.memo = memo;
                      },
                    ),
                    Divider(),
                    SizedBox(height: 50.0),
                    RaisedButton(
                      child: Text(
                        '変更',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();
                        await model.update(expenses);
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.red[500],
                      child: Text(
                        '削除',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();
                        await model.delete(expenses);
                        Navigator.pop(context);
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
