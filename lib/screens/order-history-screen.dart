import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/ordering.dart';
import 'package:ecommerce_template/widgets/order-history-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  TabController controller;
  PageController controllerPage = PageController();
  int pageIndex;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);

    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    Provider.of<AllProviders>(context, listen: false).NavBarShow(true);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<Ordering>(context, listen: false);
    final lang = Provider.of<Languages>(context);

    controller.addListener(() {
      // print(controller.index);
      if (controller.index == 0) {
        orderPro.once = false;
        controllerPage.animateToPage(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      } else if (controller.index == 1) {
        orderPro.once = false;
        controllerPage.animateToPage(1,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });

    @override
    final allPro = Provider.of<AllProviders>(context);

    return WillPopScope(
      onWillPop: () {
        allPro.NavBarShow(true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          bottom: TabBar(
            controller: controller,
            tabs: <Tab>[
              Tab(
                child: Text(
                  lang.translation['oldOrdersTitle']
                      [Languages.selectedLanguage],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  lang.translation['recentOrdersTitle']
                      [Languages.selectedLanguage],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          leading: new Container(),
          actions: <Widget>[
            Languages.selectedLanguage == 0
                ? Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            allPro.NavBarShow(true);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Text(
                          lang.translation['oldOrdersTitle']
                              [Languages.selectedLanguage],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ))
                : Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lang.translation['oldOrdersTitle']
                              [Languages.selectedLanguage],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            allPro.NavBarShow(true);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              70,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: controllerPage,
            children: <Widget>[
              RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: orderPro.getOrders(),
                    builder: (ctx, authResultSnap) {
                      if (authResultSnap.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (authResultSnap.hasError) {
                        Center(
                          child: Text(
                            lang.translation['checkInternet']
                                [Languages.selectedLanguage],
                          ),
                        );
                        return RaisedButton(
                          onPressed: () {
                            setState(() {
                              //other.getUserLocation();
                            });
                            print(authResultSnap.error.toString());
                          },
                          child: Text(
                              lang.translation['checkInternet']
                                  [Languages.selectedLanguage],
                              style: TextStyle(color: Colors.black)),
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: orderPro.allorders.map((item) {
                              if (item.status != 'Pending') {
                                return OrderHistoryItem(
                                  order: item,
                                );
                              } else {
                                return SizedBox();
                              }
                            }).toList());
                      }
                    },
                  ),
                ),
              ),
              RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: orderPro.getOrders(),
                    builder: (ctx, authResultSnap) {
                      if (authResultSnap.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (authResultSnap.hasError) {
                        Center(
                          child: Text(
                            lang.translation['checkInternet']
                                [Languages.selectedLanguage],
                          ),
                        );
                        return RaisedButton(
                          onPressed: () {
                            setState(() {
                              //other.getUserLocation();
                            });
                            print(authResultSnap.error.toString());
                          },
                          child: Text(
                              lang.translation['checkInternet']
                                  [Languages.selectedLanguage],
                              style: TextStyle(color: Colors.black)),
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: orderPro.allorders.map((item) {
                              if (item.status == 'Pending') {
                                return OrderHistoryItem(
                                  order: item,
                                );
                              } else {
                                return SizedBox();
                              }
                            }).toList());
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {});
  }
}
