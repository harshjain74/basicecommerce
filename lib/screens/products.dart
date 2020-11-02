import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commerce/data/vegetable.dart';
import 'listveg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:commerce/data/model.dart';
import 'cartScreen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void initState() {
    super.initState();
    loadproducts();
    cartdata();
  }

  //cartdata fetch old cart
  cartdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Model> items = Model.decodeModels(pref.getString('cart'));
    Provider.of<Vegetable>(context, listen: false).updatecart(items);
  }

  Future<void> loadproducts() async {
    context
        .read<Vegetable>()
        .addvegetable('images/vegetable0.jpg', 20, 1, 'Potato');
    context
        .read<Vegetable>()
        .addvegetable('images/vegetable1.jpg', 28, 1, 'Carrot');
    context
        .read<Vegetable>()
        .addvegetable('images/vegetable2.jpg', 40, 1, 'Tomato');
    context
        .read<Vegetable>()
        .addvegetable('images/vegetable3.jpg', 60, 1, 'Lemon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetables'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            ),
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Listveg(),
    );
  }
}
