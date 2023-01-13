import 'package:flutter/material.dart';

class TaskDropDown extends StatefulWidget {
  final Function(String) value;
  String? currSelect;

  TaskDropDown({Key? key, required this.value, this.currSelect})
      : super(key: key);

  @override
  _TaskDropDownState createState() => _TaskDropDownState();
}

class _TaskDropDownState extends State<TaskDropDown> {
  var currentSelectedValue;
  final tasks = ["Configure Keyboard", "Pull Trolley", "Open Muesli Box", "Check Air Conditioner", "Custom task"];

  void initState() {
    currentSelectedValue = widget.currSelect;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(

                border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconDisabledColor: Theme.of(context).primaryColor ,

                hint: Text("Task"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  widget.value(currentSelectedValue);
                  print(currentSelectedValue);
                },
                items: tasks.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}