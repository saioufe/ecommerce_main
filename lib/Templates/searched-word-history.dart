import 'package:ecommerce_template/providers/application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedWorldHistory extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final BuildContext context;
  SearchedWorldHistory({this.text, this.controller, this.context});

  @override
  _SearchedWorldHistoryState createState() => _SearchedWorldHistoryState();
}

class _SearchedWorldHistoryState extends State<SearchedWorldHistory> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<ApplicationProvider>(context, listen: true);

    return InkWell(
      onTap: () {
        setState(() {
          widget.controller.text = widget.text;
          appProvider.search(widget.text, widget.context);
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).bottomAppBarColor,
          ),
        ),
      ),
    );
  }
}
