class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  // static List<Todo> todoList() {
  //   return [
      // Todo(id: '01', todoText: 'Morning excercise', isDone: true),
      // Todo(id: '02', todoText: 'Buy groceries', isDone: false),
      // Todo(id: '03', todoText: 'Check emails', isDone: false),
      // Todo(id: '04', todoText: 'Team meeting', isDone: false),
      // Todo(id: '05', todoText: 'Work on mobile apps', isDone: false),
      // Todo(id: '06', todoText: 'Dinner with Veena', isDone: false),
  //   ];
  // }
}
