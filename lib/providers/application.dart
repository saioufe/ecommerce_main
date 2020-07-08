import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider extends ChangeNotifier {
  static const String hostName = "http://10.0.2.2/ecommerceTemplate";

  String aboutus = '';
  String facebook = '';
  String insta = '';
  String twitter = '';
  String youtube = '';
  List data = [];
  Future<void> fetchDataAboutUs() async {
    final response = await http.post('$hostName/get-aboutus-flutter.php');

    data = json.decode(response.body);
    if (data == null) {
      return;
    }

    data.forEach((newsId) {
      aboutus = newsId['aboutus'];
      facebook = newsId['facebook'];
      insta = newsId['instagram'];
      twitter = newsId['twitter'];
      youtube = newsId['youtube'];
    });

    notifyListeners();
  }
}
