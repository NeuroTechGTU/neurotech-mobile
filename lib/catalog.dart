class CatalogModel {
  static final items = [
    Item(
        id: 1,
        name: "Umudunu Kaybetme",
        desc: "Hüzün",
        price: 999,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/9/96/Umudunu_Kaybetme_afiş.jpg"),
    Item(
        id: 2,
        name: "The Mask",
        desc: "Mutluluk",
        price: 1199,
        color: "#33505a",
        image:
            "https://m.media-amazon.com/images/M/MV5BOWExYjI5MzktNTRhNi00Nzg2LThkZmQtYWVkYjRlYWI2MDQ4XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_.jpg"),
    Item(
        id: 3,
        name: "Yeşil Yol",
        desc: "Hüzün",
        price: 1299,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/thumb/3/3b/YesilYol.jpg/220px-YesilYol.jpg"),
    Item(
        id: 4,
        name: "Testere",
        desc: "Korku",
        price: 899,
        color: "#33505a",
        image:
            "https://icdn.turkiyegazetesi.com.tr/images/haberler/2016_05/buyuk/testere-alarmi-1462854396.jpg"),
    Item(
        id: 5,
        name: "iPhone 10",
        desc: "Better design",
        price: 799,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/9/96/Umudunu_Kaybetme_afiş.jpg"),
  ];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.color,
      required this.image});
}
