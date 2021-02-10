import 'package:expenses_app/screens/add_edit/add_todo_page.dart';
import 'package:expenses_app/screens/signin_signup_page.dart';
import 'package:expenses_app/screens/todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoModel>(
      create: (_) => TodoModel()..getTodoListRealTime(),
      child: Consumer<TodoModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 10.0,
              backgroundColor: Colors.white,
              title: Text(
                'Todoリスト',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
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
            body: Consumer<TodoModel>(
              builder: (context, model, child) {
                final todoList = model.todoList;
                return ListView(
                  children: todoList
                      .map(
                        (todo) => CheckboxListTile(
                          title: Text(todo.title),
                          subtitle: Text(
                              '期限；${model.formatter.format(todo.date.toDate())}'),
                          value: todo.isDone,
                          onChanged: (bool value) {
                            todo.isDone = !todo.isDone;
                            model.reload();
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }
}
