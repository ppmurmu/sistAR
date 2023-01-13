import 'package:flutter/material.dart';

class AssignToDropDown extends StatefulWidget {
  final Function(String) value;
  String? currSelect;

  AssignToDropDown({Key? key, required this.value, this.currSelect})
      : super(key: key);

  @override
  _AssignToDropDownState createState() => _AssignToDropDownState();
}

class _AssignToDropDownState extends State<AssignToDropDown> {
  var currentSelectedValue;
  final worker = ["peter", "chan"];

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

                hint: Text("Assign to"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  widget.value(currentSelectedValue);
                  print(currentSelectedValue);
                },
                items: worker.map((String value) {
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