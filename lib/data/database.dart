import 'package:hive/hive.dart';
import 'package:my_first_app/modal/todo.dart';

class TodoDatabase {
  List<Todo> todosList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    todosList=[
      Todo(id: '01', todoText: 'Morning excercise', isDone: true),
      Todo(id: '02', todoText: 'Buy groceries', isDone: false),
      Todo(id: '03', todoText: 'Check emails', isDone: false),
      Todo(id: '04', todoText: 'Team meeting', isDone: false),
      Todo(id: '05', todoText: 'Work on mobile apps', isDone: false),
      Todo(id: '06', todoText: 'Dinner with Veena', isDone: false),
    ];
  }

  void loadData() {
    todosList = _myBox.get("TODOSLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOSLIST", todosList);
  }
}