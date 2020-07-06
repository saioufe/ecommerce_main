import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/product_question.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionAnswer extends StatefulWidget {
  final ProductShow product;

  QuestionAnswer({@required this.product});

  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    final allposts = Provider.of<AllProviders>(context, listen: false);

    return AllProviders.dataOfflineAllProductsQuestion == null
        ? FutureBuilder(
            future: allposts.fetchDataProductQuestion(widget.product.id),
            builder: (ctx, authResultSnap) {
              if (authResultSnap.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (authResultSnap.hasError) {
                Center(
                  child: Text("تفقد من الاتصال بلانترنت"),
                );
                return RaisedButton(
                  onPressed: () {
                    setState(() {
                      //other.getUserLocation();
                    });
                    print(authResultSnap.error.toString());
                  },
                  child: Text("تفقد من الاتصال بلانترنت",
                      style: TextStyle(color: Colors.black)),
                );
              } else {
                return Container(
                  height: 200,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                            children: allposts.questions.map((item) {
                          return Template(
                            question: item.question,
                            answer: item.answer,
                          );
                        }).toList()),
                      ),
                    ),
                  ),
                );
              }
            })
        : Container(
            height: 200,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                      children: allposts.questions.map((item) {
                    return Template(
                      question: item.question,
                      answer: item.answer,
                    );
                  }).toList()),
                ),
              ),
            ),
          );
  }
}

class Template extends StatelessWidget {
  const Template({Key key, @required this.question, this.answer})
      : super(key: key);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.help_outline,
              color: Colors.grey,
            ),
            Container(
              width: 200,
              child: Text(
                question,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            Container(
              width: 200,
              child: Text(
                answer,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
