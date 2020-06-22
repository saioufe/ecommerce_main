import 'package:flutter/material.dart';

class AddressOrderTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.2,
              blurRadius: 1.9)
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("الاسم"),
              Container(
                  width: 10,
                  child: Divider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  "سيف ماهر محمد ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("العنوان"),
              Container(
                  width: 10,
                  child: Divider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  "حي الخضراء مجاور جامع الشهيدين",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(child: Text("الرقم")),
              Container(
                  width: 10,
                  child: Divider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  "9647803040266",
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
