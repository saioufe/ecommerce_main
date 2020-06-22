import 'package:flutter/material.dart';

class SizeProductBox extends StatefulWidget {
  final String sizeText;
  SizeProductBox({this.sizeText});
  @override
  _SizeProductBoxState createState() => _SizeProductBoxState();
}

class _SizeProductBoxState extends State<SizeProductBox> {
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
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: borderOn
                ? Colors.grey.withOpacity(0.1)
                : Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 8 , left:5 , right: 5),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
            child: Center(
                child: Text(
              widget.sizeText,
              style: TextStyle(fontSize:borderOn ?  19 : 22),
              textAlign: TextAlign.center,
            )),
          ),
        ),
      ),
    );
  }
}
