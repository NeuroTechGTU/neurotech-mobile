import 'package:flutter/material.dart';
import 'package:neurotech_ceng/catalog.dart';

import 'movie_information.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              item.image,
              height: 90,
              width: 90,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    autoFill(item.name);
                  },
                  child: Text(item.name),
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
                        color: Colors.indigo.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            15))), /*
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
