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
        name: "Otomotik Portakal",
        desc: "Öfke",
        price: 1299,
        color: "#33505a",
        image:
            "https://ae01.alicdn.com/kf/HTB1bPuvRpXXXXawXFXXq6xXFXXXU.jpg_640x640Q90.jpg_.webp"),
    Item(
        id: 3,
        name: "Maske",
        desc: "Mutluluk",
        price: 1199,
        color: "#33505a",
        image:
            "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR8mCvnB9sWjzXiNdvwJiCOt_13xWmZqIIVEP-DfuNoW6H8SPAt"),
    Item(
        id: 4,
        name: "Çığlık",
        desc: "Korku",
        price: 899,
        color: "#33505a",
        image:
            "https://www.arthipo.com/image/cache/catalog/poster/movie/759-1554/pfilm1156-scream_02eeacd0-film-movie-posters-cinema-kanvas-tablo-canvas-712x1000.jpg"),
    Item(
        id: 5,
        name: "Cumali Ceber",
        desc: "Antipati",
        price: 1299,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/9/9f/Cumali_ceber_poster.jpg"),
    Item(
        id: 6,
        name: "Hababam Sınıfı",
        desc: "Komedi",
        price: 799,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/6/6f/Hababam-sinifi.jpg"),
    Item(
        id: 7,
        name: "Chucky",
        desc: "Korku",
        price: 799,
        color: "#33505a",
        image:
            "https://tr.web.img2.acsta.net/pictures/21/07/22/10/33/5804587.jpg"),
    Item(
        id: 8,
        name: "Buz Devri",
        desc: "Mutluluk",
        price: 799,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/a/ad/Buz_Devri_afis.jpg"),
    Item(
        id: 9,
        name: "Düğün Dernek",
        desc: "Komedi",
        price: 799,
        color: "#33505a",
        image:
            "https://mir-s3-cdn-cf.behance.net/project_modules/disp/3bc57e12441927.5626f7db659a0.jpg"),
    Item(
        id: 10,
        name: "Hayal Mi Gerçek Mi?",
        desc: "Antipati",
        price: 799,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/5/5e/Enes_Batur_Hayal_mi_Ger%C3%A7ek_mi%3F.jpg"),
    Item(
        id: 11,
        name: "Soysuzlar Çetesi",
        desc: "Öfke",
        price: 799,
        color: "#33505a",
        image:
            "https://upload.wikimedia.org/wikipedia/tr/thumb/2/22/Inglourious_Basterds_film_posteri.jpg/220px-Inglourious_Basterds_film_posteri.jpg"),
    Item(
        id: 12,
        name: "Çizgili Pijamalı Çocuk",
        desc: "Hüzün",
        price: 799,
        color: "#33505a",
        image:
            "https://i.jeded.com/i/the-boy-in-the-striped-pyjamas-the-boy-in-the-striped-pajamas.28395.jpg"),
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

