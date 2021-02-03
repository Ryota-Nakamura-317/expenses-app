import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:expenses_app/home/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPricePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _payment = ['現金', 'クレジットカード', 'QRコード決済'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
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
                      name: 'payment',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.payment),
                        border: InputBorder.none,
                      ),
                      allowClear: true,
                      hint: Text('支払い方法'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      items: _payment
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
                    FormBuilderDateTimePicker(
                      name: 'date',
                      initialValue: DateTime.now(),
                      //fieldHintText: '日付',
                      inputType: InputType.date,
                      format: DateFormat('yMMMMEEEEd'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      //DateTime型からTimeStamp型にしてdateに代入
                      onChanged: (DateTime date) {
                        model.date = Timestamp.fromDate(date);
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
                        await model.add();
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
