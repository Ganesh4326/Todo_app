import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_app/constants/colors.dart';
import 'package:my_first_app/data/database.dart';
import 'package:my_first_app/widgets/todo_item.dart';

import '../modal/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _myBox = Hive.openBox('mybox');

  TodoDatabase db = TodoDatabase();

  // final todosList = Todo.todoList();

  final _todoController = TextEditingController();

  List<Todo> foundTodo = [];


  @override
  initState() {
    foundTodo = db.todosList;
    print(foundTodo);

    var todosList = _myBox.get("TODOSLIST");

    if (foundTodo == null) {
      db.createInitialData();
    } else {
      db.updateDataBase();
    }
    super.initState();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    db.updateDataBase();
  }

  void _deleteTodoItem(String id) {
    setState(() {
      db.todosList.removeWhere((element) => element.id == id);
    });
    db.updateDataBase();
  }

  void _addTodoItem(String todo) {
    setState(() {
      db.todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String key) {
    List<Todo> results = [];
    if (key.isEmpty || key == '') {
      results = db.todosList;
    } else {
      results = db.todosList
          .where((element) =>
              element.todoText!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }

    setState(() {
      foundTodo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/ganesh.png'),
              ),
            )
          ],
        )),
        body: Stack(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              // margin: EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      onChanged: (val) => _runFilter(val),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: tdBlack,
                            size: 24,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            maxHeight: 20,
                            maxWidth: 25,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 25),
                        child: Text(
                          'All todos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todo in foundTodo)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        )
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a new Todo', border: InputBorder.none),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        _addTodoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
