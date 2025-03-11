import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final letter;
  final function;
  final color;

  MyButton({this.letter, this.function, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color,
          width: 50,
          height: 50,
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
              child: Text(letter),
            ),
          ),
        ),
      ),
    );
  }
}
