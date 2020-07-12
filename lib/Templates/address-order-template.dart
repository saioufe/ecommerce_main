import 'package:ecommerce_template/models/address.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressOrderTemplate extends StatefulWidget {
  final Address address;
  final bool isThisEdit;

  AddressOrderTemplate(
    this.address,
    this.isThisEdit,
  );

  @override
  _AddressOrderTemplateState createState() => _AddressOrderTemplateState();
}

class _AddressOrderTemplateState extends State<AddressOrderTemplate> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  widget.address.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Text("الاسم"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 150,
                child: Center(
                    child: Text(
                  widget.address.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Text("العنوان"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  widget.address.phone,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Container(child: Text("الرقم")),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: Center(
                    child: Text(
                  widget.address.city,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )),
              Container(child: Text("المدينة")),
            ],
          ),
          widget.isThisEdit == true ? Divider() : SizedBox(),
          widget.isThisEdit == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          cartProvider
                              .deleteAddress(widget.address.id)
                              .then((value) {
                            CartProvider.once3 = false;
                          });
                        });
                      },
                      color: Colors.redAccent,
                      child: Container(
                        width: 100,
                        child: Center(
                            child: Text(
                          "حذف",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs
                            .setString('address', widget.address.id)
                            .then((value) {
                          cartProvider.getChoosenAddress();
                          
                          Navigator.of(context).pop();
                        });
                      },
                      color: Colors.green,
                      child: Container(
                        width: 100,
                        child: Center(
                            child: Text(
                          "اختيار",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
