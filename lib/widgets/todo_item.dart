import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/constants/colors.dart';

import '../modal/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  final onTodoChanged;
  final onDeleteItem;

  const TodoItem({super.key, required this.todo, required this.onTodoChanged, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          print("checkbox");
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        tileColor: Colors.white,
        leading: (Icon(
          todo.isDone?Icons.check_box: Icons.check_box_outline_blank,
          color: tdBlue,
        )),
        title: Text(
          todo.todoText! ,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              print("delete icon");
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
