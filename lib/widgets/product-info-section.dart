import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/product_question.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/widgets/question-answer.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductInfoPressed extends StatefulWidget {
  final ProductShow product;
  ProductInfoPressed({this.product});

  @override
  _ProductInfoPressedState createState() => _ProductInfoPressedState();
}

class _ProductInfoPressedState extends State<ProductInfoPressed> {
  bool isExpanded = false;
  bool isExpanded2 = false;
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context);

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 0.3, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right 10
              0, // vertical, move down 10
            ),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 230,
                        child: GroovinExpansionTile(
                          initiallyExpanded: true,
                          trailing: Container(
                              //padding: EdgeInsets.only(left:15),
                              child: Text(
                            lang.translation['clickToSeeMore']
                                [Languages.selectedLanguage],
                            textAlign: TextAlign.right,
                          )),
                          defaultTrailingIconColor:
                              Colors.grey.withOpacity(0.5),
                          leading: Icon(
                            Icons.looks_one,
                            color: Colors.grey,
                          ),
                          title: Text(
                            "",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.black),
                          ),
                          onExpansionChanged: (value) {
                            setState(() {
                              isExpanded = value;
                            });
                          },
                          inkwellRadius: !isExpanded
                              ? BorderRadius.all(Radius.circular(8.0))
                              : BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                ),
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      widget.product.description,
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    lang.translation['DescriptionTitle']
                        [Languages.selectedLanguage],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'tajawal',
                        color: Theme.of(context).bottomAppBarColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          widget.product.isQuestion == "1"
              ? Divider(
                  endIndent: 40,
                  indent: 40,
                )
              : SizedBox(),
          widget.product.isQuestion == "1"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 230,
                                      child: GroovinExpansionTile(
                                        initiallyExpanded: false,
                                        trailing: Container(
                                            //padding: EdgeInsets.only(left:15),
                                            child: Text(
                                          lang.translation['questionAndAnswers']
                                              [Languages.selectedLanguage],
                                          textAlign: TextAlign.right,
                                        )),
                                        defaultTrailingIconColor:
                                            Colors.grey.withOpacity(0.5),
                                        leading: Icon(
                                          Icons.looks_two,
                                          color: Colors.grey,
                                        ),
                                        title: Text(
                                          "",
                                          textAlign: TextAlign.justify,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onExpansionChanged: (value) {
                                          setState(() {
                                            isExpanded2 = value;
                                          });
                                        },
                                        inkwellRadius: !isExpanded2
                                            ? BorderRadius.all(
                                                Radius.circular(8.0))
                                            : BorderRadius.only(
                                                topRight: Radius.circular(8.0),
                                                topLeft: Radius.circular(8.0),
                                              ),
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0),
                                              ),
                                              child: QuestionAnswer(
                                                product: widget.product,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          lang.translation['questionsTitle']
                              [Languages.selectedLanguage],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'tajawal',
                              color: Theme.of(context).bottomAppBarColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
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
