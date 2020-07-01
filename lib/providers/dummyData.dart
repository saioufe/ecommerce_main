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
      id: "11",
      title: "اهمية السؤال قبل الطلب عندما تكون في حيرة من امرك",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post1.png",
      date: "12/2/2020",
    ),
    News(
      id: "22",
      title: "طريقة التسوق بلطريقة المثالية",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post2.png",
      date: "12/2/2020",
    ),
    News(
      id: "33",
      title: "تعرف على الخصائص الكاملة لتطبيق مشاريع ابداعية للتسوق الجديد",
      desc:
          "شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع شرح عن الموضوع",
      image: "post3.png",
      date: "12/2/2020",
    ),
  ];

  List<Category> _categories = [
    Category(
      id: "111",
      name: "ملابس رجالية",
      image: "category2.jpg",
      subCategories: ["احذية", "قمصان", "تي شيرت", "قبعات"],
    ),
    Category(
      id: "222",
      name: "ملابس نسائية",
      image: "category1.jpg",
      subCategories: [],
    ),
    Category(
      id: "333",
      name: "احذية",
      image: "category3.jpeg",
      subCategories: ["سبورت", "تران شوز", "رسمي"],
    ),
    Category(
      id: "444",
      name: "هواتف ذكية",
      image: "category4.jpg",
      subCategories: ["سامسونك", "ايفون", "هواوي", "LG"],
    ),
    Category(
      id: "555",
      name: "قرطاسية",
      image: "category5.jpeg",
      subCategories: ["دفاتر", "اقلام", "كتب", "ملصقات"],
    ),
    Category(
      id: "666",
      name: "بطاقات",
      image: "category6.jpg",
      subCategories: ["itunes", "Xbox Live", "PSN", "Zain Cash"],
    ),
    Category(
      id: "777",
      name: "اثاث",
      image: "category7.jpg",
      subCategories: ["مكتبي", "مطبخ", "غرف نوم", "استقبال"],
    ),
    Category(
      id: "888",
      name: "طعام",
      image: "category8.jpg",
      subCategories: ["سوشي", "هندي", "عراقي", "لبناني"],
    ),
    Category(
      id: "999",
      name: "العاب الفيديو",
      image: "category9.jpg",
      subCategories: [
        "PlayStation 4",
        "Xbox One",
        "nintendo switch",
        "PC",
        "Xbox One",
        "nintendo switch",
        "PC",
        "Xbox One",
        "nintendo switch",
        "PC"
      ],
    ),
  ];
  int selectedCat = 0;
  void setCat(int index) {
    selectedCat = index;
    notifyListeners();
  }

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
