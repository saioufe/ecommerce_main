import 'package:flutter/material.dart';

class ColorProductCircle extends StatefulWidget {
  final Color color;
  ColorProductCircle({this.color});

  @override
  _ColorProductCircleState createState() => _ColorProductCircleState();
}

class _ColorProductCircleState extends State<ColorProductCircle> {
  bool borderOn = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          borderOn = !borderOn;
        });
      },
      child: AnimatedContainer(
        
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.9),
          //     spreadRadius: 0.5,
          //     blurRadius: 1.5,
          //   ),
          // ],
          shape: BoxShape.circle,
          border: Border.all(
            color: borderOn ? Colors.grey.withOpacity(0.1) : Theme.of(context).primaryColor,
            width: 4,
          ),
        ),
        child: Center(
          child: Container(
            decoration:
                BoxDecoration(color: widget.color, shape: BoxShape.circle),
            child: SizedBox(
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}
