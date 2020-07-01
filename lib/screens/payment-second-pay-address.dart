import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:flutter/material.dart';

class PaymentSecondPayAddress extends StatefulWidget {
  PageController c;
  PaymentSecondPayAddress({this.c});

  @override
  _PaymentSecondPayAddressState createState() =>
      _PaymentSecondPayAddressState();
}

class _PaymentSecondPayAddressState extends State<PaymentSecondPayAddress> {
  String radioItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("عنوان التوصيل"),
            Divider(
              endIndent: 100,
              indent: 100,
            ),
            AddressOrderTemplate(), // this is the order address template
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              child: RaisedButton(
                child: Text(
                  "تغيير عنوان السكن",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("طريقة الدفع"),
            Divider(
              endIndent: 100,
              indent: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('دفع عند التوصيل'),
                      Radio(
                        value: 'Item 2',
                        activeColor: Theme.of(context).primaryColor,
                        groupValue: radioItem,
                        onChanged: (val) {
                          setState(() {
                            radioItem = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Credit Card / Debit Card',
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.withOpacity(0.9)),
                      ),
                      Radio(
                        value: 'Item 3',
                        activeColor: Theme.of(context).primaryColor,
                        groupValue: radioItem,
                        onChanged: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "متابعة",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onPressed: () {
                widget.c.animateToPage(2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
