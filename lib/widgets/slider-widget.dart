import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        child: SizedBox(
          height: 150.0,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Carousel(
            boxFit: BoxFit.cover,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).primaryColor,
            dotIncreaseSize: 1.2,
            autoplayDuration: Duration(milliseconds: 2000),
            images: [
              Image.asset(
                'assets/images/cover.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/cover.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/cover.jpg',
                fit: BoxFit.cover,
              ),
              // ExactAssetImage("assets/images/LaunchImage.jpg")
            ],
          ),
        ),
      ),
    );
  }
}
