import 'package:flutter/material.dart';

class CustomRoundButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
   CustomRoundButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color
  }) : super(key: key);

  @override
  _CustomRoundButtonState createState() => _CustomRoundButtonState();
}

class _CustomRoundButtonState extends State<CustomRoundButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
         widget.color,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.black, fontSize: 25),

        ),
      ),
    );
  }
}