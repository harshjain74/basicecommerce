import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:commerce/data/vegetable.dart';
import 'package:flutter/cupertino.dart';
import 'producttile.dart';

class Listveg extends StatefulWidget {
  @override
  _ListvegState createState() => _ListvegState();
}

class _ListvegState extends State<Listveg> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Vegetable>(
      builder: (context, data, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final product = data.listveg[index];

            return ProductTile(
                path: product.filepath,
                name: product.vegetablename,
                price: product.priceperkg,
                quantity: product.quantity);
          },
          itemCount: data.length,
        );
      },
    );
  }
}
