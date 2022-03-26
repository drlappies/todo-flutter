import 'package:flutter/material.dart';
import './todo.checkbox.dart';

class Todo extends StatefulWidget {
  final String id;
  final Function updateTodo;
  final Function deleteTodo;
  final Function toggleIsDone;
  final String task;
  final bool isDone;

  const Todo(this.id, this.task, this.isDone, this.updateTodo, this.deleteTodo,
      this.toggleIsDone,
      {Key? key})
      : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool isEditing = false;

  void handleSelect(action) {
    switch (action) {
      case "UPDATE":
        {
          setState(() {
            isEditing = !isEditing;
          });
        }
        break;

      case "DELETE":
        {
          widget.deleteTodo(widget.id);
        }
        break;
    }
  }

  void handleSubmit(String id, String task) {
    widget.updateTodo(id, task);
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        height: 50,
        width: double.infinity,
        child: Row(children: [
          TodoCheckbox(widget.id, widget.isDone, widget.toggleIsDone),
          Expanded(
            child: isEditing
                ? TextFormField(
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 5),
                    ),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    initialValue: widget.task,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => handleSubmit(widget.id, value),
                  )
                : Text(widget.task,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    )),
          ),
          PopupMenuButton(
              onSelected: (value) => handleSelect(value),
              child: Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: const Icon(Icons.more_vert, color: Colors.red)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        enabled: !widget.isDone,
                        value: "UPDATE",
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.edit, color: Colors.white, size: 15),
                              Text("Update")
                            ])),
                    PopupMenuItem(
                      value: "DELETE",
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.delete, color: Colors.white, size: 15),
                            Text("Delete")
                          ]),
                    ),
                  ]),
        ]));
  }
}
