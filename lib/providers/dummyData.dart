import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/models/Product.dart';
import 'package:flutter/widgets.dart';

class DummyData extends ChangeNotifier {
  List<Product> _products = [
    Product(
      id: "1",
      title: "قميص نسائي مميز الشكل",
      price: "22,000",
      favorite: false,
      images: "girl2.jpg",
      hasDiscount: true,
      discount: "18,000",
    ),
    Product(
      id: "2",
      title: "كوفر ايفون 10 ابيض ",
      price: "10,000",
      favorite: true,
      images: "product1.jpg",
      hasDiscount: false,
    ),
    Product(
      id: "3",
      title: "سماعات ايربودس للايفون لشخصيات السوبر هيروز",
      price: "34,500",
      favorite: false,
      images: "product2.jpg",
      hasDiscount: false,
    ),
    Product(
      id: "4",
      title: "محدده ورق لعشاق القراءة",
      price: "1,000",
      favorite: true,
      images: "product5.jpg",
      hasDiscount: true,
      discount: "250",
    ),
    Product(
      id: "5",
      title:
          "اللعبة اللوحية زومبي سايد بلغة الانكليزية النسخه الكاملة والمحسنة",
      price: "150,000",
      favorite: false,
      images: "product6.jpg",
      hasDiscount: false,
    ),
    Product(
      id: "6",
      title: "مجسم لشخصية ناروتو دقيق التفاصيل ومفصلي",
      price: "13,000",
      favorite: true,
      images: "product9.jpg",
      hasDiscount: true,
      discount: "2,000",
    ),
    Product(
      id: "7",
      title:
          "ملصقات لماعة قوية عند الالتصاق للقرطاسية واللابتوبات والواح التزلج",
      price: "5,250",
      favorite: false,
      images: "product12.jpg",
      hasDiscount: false,
    ),
  ];

  List<News> _news = [
    News(
      id: "1",
      title: "اهمية السؤال قبل الطلب عندما تكون في حيرة من امرك",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post1.png",
    ),
    News(
      id: "2",
      title: "طريقة التسوق بلطريقة المثالية",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post2.png",
    ),
    News(
      id: "3",
      title: "تعرف على الخصائص الكاملة لتطبيق مشاريع ابداعية للتسوق الجديد",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post3.png",
    ),
  ];

  List<Category> _categories = [
    Category(
      id: "1",
      name: "ملابس رجالية",
      image: "category2.jpg",
    ),
    Category(
      id: "2",
      name: "ملابس نسائية",
      image: "category1.jpg",
    ),
    Category(
      id: "3",
      name: "احذية",
      image: "category3.jpeg",
    ),
    Category(
      id: "4",
      name: "هواتف ذكية",
      image: "category4.jpg",
    ),
    Category(
      id: "5",
      name: "قرطاسية",
      image: "category5.jpeg",
    ),
    Category(
      id: "6",
      name: "بطاقات",
      image: "category6.jpg",
    ),
    Category(
      id: "7",
      name: "اثاث",
      image: "category7.jpg",
    ),
    Category(
      id: "8",
      name: "طعام",
      image: "category8.jpg",
    ),
    Category(
      id: "9",
      name: "العاب الفيديو",
      image: "category9.jpg",
    ),
  ];

  List<Product> get products {
    return _products;
  }

  List<News> get news {
    return _news;
  }

  List<Category> get categories {
    return _categories;
  }
}
