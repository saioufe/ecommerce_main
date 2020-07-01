import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimilarItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dummyData = Provider.of<DummyData>(context);

    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 200,
                child: ProductMainTemplate(
                  product: dummyData.products[0],
                  isMain: true,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 200,
                height: 400,
                child: ProductMainTemplate(
                  product: dummyData.products[1],
                  isMain: true,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 200,
                height: 400,
                child: ProductMainTemplate(
                  product: dummyData.products[2],
                  isMain: true,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 200,
                height: 400,
                child: ProductMainTemplate(
                  product: dummyData.products[3],
                  isMain: true,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 200,
                height: 400,
                child: ProductMainTemplate(
                  product: dummyData.products[4],
                  isMain: true,
                ),
              ),
              // ProductMainTemplate(
            ],
          )),
    ));
  }
}
