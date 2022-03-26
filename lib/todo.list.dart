import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './todo.dart';
import './todo.create.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isCreating = false;
  List todos = [
    {
      "id": const Uuid().v4(),
      "todo": "This is an example todo 1",
      "isDone": true
    },
    {"id": const Uuid().v4(), "todo": "I will eat cake", "isDone": true},
    {"id": const Uuid().v4(), "todo": "Learn Flutter", "isDone": false},
    {"id": const Uuid().v4(), "todo": "Learn Dart", "isDone": false},
  ];

  void createTodo(String todo) {
    setState(() {
      if (todo.isEmpty) {
        isCreating = false;
        return;
      }
      todos = [
        {"id": const Uuid().v4(), "todo": todo, "isDone": false},
        ...todos
      ];
      isCreating = false;
    });
  }

  void removeTodo(String id) {
    setState(() {
      todos.removeWhere((el) => el["id"] == id);
    });
  }

  void updateTodo(String id, String todo) {
    setState(() {
      todos[todos.indexWhere((el) => el["id"] == id)]["todo"] = todo;
    });
  }

  void toggleIsDone(String id, bool isDone) {
    setState(() {
      todos[todos.indexWhere((el) => el["id"] == id)]["isDone"] = isDone;
    });
  }

  void toggleIsCreating() {
    setState(() {
      isCreating = !isCreating;
    });
  }

  final ScrollController _listViewScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listViewScrollController.addListener(() {
      if (_listViewScrollController.offset < -150 && isCreating == false) {
        setState(() {
          isCreating = true;
        });
      } else if (_listViewScrollController.offset > 100 && isCreating == true) {
        setState(() {
          isCreating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Todo List"),
          ),
          body: ListView(
            controller: _listViewScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              if (isCreating) TodoCreate(createTodo, toggleIsCreating),
              ...todos.map((el) => Todo(el["id"], el["todo"], el["isDone"],
                  updateTodo, removeTodo, toggleIsDone))
            ],
          )),
    );
  }
}
