import 'package:expenses_app/screens/add_edit/add_todo_page.dart';
import 'package:expenses_app/screens/todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: TodoModel()..getTodoListRealTime(),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 10.0,
            backgroundColor: Colors.white,
            title: Text(
              '',
              style: TextStyle(
                color: Colors.teal[900],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Consumer<TodoModel>(builder: (context, model, child) {
                final isActive = model.completeButton();
                return FlatButton(
                  onPressed: isActive
                      ? () async {
                          model.deleteCheckedItems();
                        }
                      : null,
                  child: Text(
                    '完了',
                    style: TextStyle(
                        color: isActive
                            ? Colors.blueGrey[800]
                            : Colors.black.withOpacity(0.0)),
                  ),
                );
              })
            ],
          ),
          body: Consumer<TodoModel>(
            builder: (context, model, child) {
              final todoList = model.todoList;
              return todoList == null
                  ? Container()
                  : ListView(
                      children: todoList
                          .map(
                            (todo) => Card(
                              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                              child: CheckboxListTile(
                                title: Text(todo.title),
                                subtitle: Text(
                                    '期限；${model.formatter.format(todo.date.toDate())}'),
                                value: todo.isDone,
                                onChanged: (bool value) {
                                  todo.isDone = !todo.isDone;
                                  model.reload();
                                },
                              ),
                            ),
                          )
                          .toList(),
                    );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey[400],
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
        ));
  }
}
