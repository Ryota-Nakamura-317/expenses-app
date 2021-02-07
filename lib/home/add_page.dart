import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/home/add_model.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPricePage extends StatelessWidget {
  final ExpensesUser expenses;
  AddPricePage({this.expenses});
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    //アップデートの判断

    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '支出登録',
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
                      name: 'title',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '金額',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String price) {
                        model.price = price;
                      },
                    ),
                    Divider(),
                    FormBuilderDropdown(
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
                      onChanged: (String payments) {
                        model.payments = payments;
                      },
                    ),
                    Divider(),
                    FormBuilderDropdown(
                      name: 'category',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.category),
                        border: InputBorder.none,
                      ),
                      allowClear: true,
                      hint: Text('カテゴリ'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      items: model.categoryList
                          .map((categoryList) => DropdownMenuItem(
                                value: categoryList,
                                child: Text('$categoryList'),
                              ))
                          .toList(),
                      onChanged: (String category) {
                        model.category = category;
                      },
                    ),
                    Divider(),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      initialDate: DateTime.now(),
                      inputType: InputType.date,
                      format: DateFormat('yMMMMEEEEd'),
                      decoration: InputDecoration(
                        hintText: 'タップして日付を選択',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
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
                    FormBuilderTextField(
                      cursorColor: Colors.blueGrey,
                      name: 'メモ',
                      maxLines: 20,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メモ',
                        prefixIcon: Icon(Icons.text_fields),
                      ),
                      onChanged: (String memo) {
                        model.memo = memo;
                      },
                    ),
                    Divider(),
                    SizedBox(height: 50.0),
                    RaisedButton(
                      child: Text(
                        '追加',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();
                        await model.add(expenses);
                        //todo 処理
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
