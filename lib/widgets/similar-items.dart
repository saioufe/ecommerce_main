import 'package:ecommerce_template/Templates/news-home-template.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimilarItems extends StatelessWidget {
  final ProductShow product;
  SimilarItems(this.product);
  @override
  Widget build(BuildContext context) {
    final allposts = Provider.of<AllProviders>(context, listen: false);
    final lang = Provider.of<Languages>(context);
    return Center(
      child: AllProviders.dataOfflineAllProductsSimilar == null
          ? FutureBuilder(
              future: allposts.fetchDataAllProductsOnSimilar(
                  product.mainCategory, product.subCategories[0]),
              builder: (ctx, authResultSnap) {
                if (authResultSnap.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (authResultSnap.hasError) {
                  Center(
                      child: Text(
                    lang.translation['checkInternet']
                        [Languages.selectedLanguage],
                  ));
                  return RaisedButton(
                    onPressed: () {
                      print(authResultSnap.error.toString());
                    },
                    child: Text(
                        lang.translation['checkInternet']
                            [Languages.selectedLanguage],
                        style: TextStyle(color: Colors.black)),
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: allposts.allProductsSimilar.map((item) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 250,
                                width: 200,
                                child: ProductMainTemplate(
                                  product: ProductShow(
                                    id: item.id,
                                    title: item.title,
                                    titleEngilsh: item.titleEngilsh,
                                    description: item.description,
                                    descriptionEnglish: item.descriptionEnglish,
                                    price: item.price,
                                    discount: item.discount,
                                    favorite: item.favorite,
                                    image: item.image,
                                    mainCategory: item.mainCategory,
                                    discountPercentage: item.discountPercentage,
                                    subCategories: item.subCategories,
                                    isQuestion: item.isQuestion,
                                    date: item.date,
                                    noColor: item.noColor,
                                  ),
                                  isMain: false,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              })
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: allposts.allProductsSimilar.map((item) {
                    return Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 250,
                          width: 200,
                          child: ProductMainTemplate(
                            product: ProductShow(
                              id: item.id,
                              title: item.title,
                              titleEngilsh: item.titleEngilsh,
                              description: item.description,
                              descriptionEnglish: item.descriptionEnglish,
                              price: item.price,
                              discount: item.discount,
                              favorite: item.favorite,
                              image: item.image,
                              mainCategory: item.mainCategory,
                              subCategories: item.subCategories,
                              discountPercentage: item.discountPercentage,
                              isQuestion: item.isQuestion,
                              date: item.date,
                              noColor: item.noColor,
                            ),
                            isMain: false,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
