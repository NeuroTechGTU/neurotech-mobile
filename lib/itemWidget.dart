import 'package:flutter/material.dart';
import 'package:neurotech_ceng/catalog.dart';

import 'movie_information.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListTile(
            onTap: () {
              autoFill(item.name);
            },
            leading: Container(
              width: width / 4,
              height: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      item.image,
                    )),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                color: Colors.teal.shade200,
              ),
            ),
            /*Image.network(
              item.image,
              height: 90,
              width: 90,
            ),*/
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ), /*Text(item.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))*/
              ),
            ),
            subtitle: Center(
                child: Text(item.desc,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            14))), /*
              trailing: Text(
                "\$${item.price}",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),*/
          ),
        ),
      ),
    );
  }
}
