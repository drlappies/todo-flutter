import 'package:flutter/material.dart';

class TodoCreate extends StatelessWidget {
  final Function createTodo;
  final Function toggleCreating;

  const TodoCreate(this.createTodo, this.toggleCreating, {Key? key})
      : super(key: key);

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
          Expanded(
              child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 5),
                  ),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  autofocus: true,
                  onFieldSubmitted: (value) => createTodo(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter something";
                    }
                    return null;
                  })),
          IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => toggleCreating(),
              color: Colors.red)
        ]));
  }
}
