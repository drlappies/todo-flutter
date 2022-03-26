import 'package:flutter/material.dart';

class TodoCheckbox extends StatelessWidget {
  final String id;
  final bool isDone;
  final Function onChange;

  const TodoCheckbox(this.id, this.isDone, this.onChange, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isDone,
      onChanged: (value) => onChange(id, value),
    );
  }
}
