import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:commerce/data/model.dart';
import 'package:commerce/data/vegetable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';

class ProductTile extends StatefulWidget {
  final String name;
  final String path;
  final int quantity;

  final int price;

  ProductTile({this.path, this.price, this.quantity, this.name});

  @override
  _ProductTileState createState() =>
      _ProductTileState(quantity, price, price / 4);
}

class _ProductTileState extends State<ProductTile> {
  int qty;
  int price;
  double pricediff;

  //save cart in preferences
  savecart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String items = Model.encodeModels(
        Provider.of<Vegetable>(context, listen: false).listcart);
    prefs.setString('cart', items);
  }

  _ProductTileState(this.qty, this.price, this.pricediff);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    widget.path,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(widget.name),
                      ),
                      Expanded(
                        child: Text('Rs.${price.toString()}'),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Qty.'),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (qty == 1) {
                                      qty = 750;
                                      price -= pricediff.toInt();
                                    } else if (qty > 250) {
                                      qty -= 250;
                                      price -= pricediff.toInt();
                                    } else {
                                      Flushbar(
                                        flushbarPosition:
                                            FlushbarPosition.BOTTOM,
                                        message: "Minimum quantity",
                                        backgroundColor: Colors.green[300],
                                        duration: Duration(seconds: 5),
                                      )..show(context);
                                    }
                                  });
                                },
                                icon: Icon(CupertinoIcons.minus_circled),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${qty.toString()}${qty == 1 ? 'kg' : 'gm'}',
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                  icon: Icon(CupertinoIcons.add_circled),
                                  onPressed: () {
                                    setState(() {
                                      if (qty > 1) {
                                        if (qty == 750) {
                                          qty = 1;
                                          price += pricediff.toInt();
                                        } else {
                                          qty += 250;
                                          price += pricediff.toInt();
                                        }
                                      } else {
                                        Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          message: "Maximum quantity",
                                          backgroundColor: Colors.red[300],
                                          duration: Duration(seconds: 5),
                                        )..show(context);
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {
                context
                    .read<Vegetable>()
                    .addcart(widget.path, price, qty, widget.name);
                savecart();
              },
              child: Text(
                'Buy Now',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
