import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final allposts = Provider.of<AllProviders>(context, listen: true);

    return InkWell(
      onTap: () {
        setState(() {
          borderOn = !borderOn;
          AllProviders.selectedDiscount = '';
          AllProviders.selectedPercentage = 0.0;
          allposts.isAnyColorSelected(widget.color.toString());

          AllProviders.selectedSize = '';
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
            color: AllProviders.selectedColor != widget.color.toString()
                ? Colors.grey.withOpacity(0.1)
                : Theme.of(context).primaryColor,
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
