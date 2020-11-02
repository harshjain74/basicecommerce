import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commerce/data/vegetable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:commerce/data/model.dart';
import 'ordersummary.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  void initState() {
    super.initState();
    Provider.of<Vegetable>(context, listen: false)
        .gettotal(Provider.of<Vegetable>(context, listen: false).listcart);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  int qty = 0;

  int price = 0;
  double pricediff = 0;

  savecart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String items = Model.encodeModels(
        Provider.of<Vegetable>(context, listen: false).listcart);
    prefs.setString('cart', items);
  }

  cartdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Model> items = Model.decodeModels(pref.getString('cart'));
    Provider.of<Vegetable>(context, listen: false).checkout(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Consumer<Vegetable>(
              builder: (context, data, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final product = data.listcart[index];

                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 240,
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
                                    product.filepath,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Text(product.vegetablename),
                                      ),
                                      Expanded(
                                        child: Text(
                                            'Rs.${product.priceperkg.toString()}'),
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
                                                    qty = product.quantity;
                                                    price = product.priceperkg;
                                                    pricediff = Provider.of<
                                                                    Vegetable>(
                                                                context,
                                                                listen: false)
                                                            .listveg
                                                            .singleWhere((element) =>
                                                                element
                                                                    .filepath ==
                                                                product
                                                                    .filepath)
                                                            .priceperkg /
                                                        4;
                                                  });
                                                  setState(() {
                                                    if (qty == 1 && qty != 0) {
                                                      qty = 750;
                                                      price -=
                                                          pricediff.toInt();
                                                    } else if (qty > 0) {
                                                      qty -= 250;

                                                      price -=
                                                          pricediff.toInt();
                                                    } else {
                                                      print('item deleted');
                                                    }
                                                    Provider.of<Vegetable>(
                                                            context,
                                                            listen: false)
                                                        .updatecartvalue(
                                                            price, index, qty);
                                                    savecart();
                                                  });
                                                },
                                                icon: Icon(CupertinoIcons
                                                    .minus_circled),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${product.quantity.toString()}${qty == 1 ? 'kg' : 'gm'}',
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  icon: Icon(CupertinoIcons
                                                      .add_circled),
                                                  onPressed: () {
                                                    setState(() {
                                                      qty = product.quantity;
                                                      price =
                                                          product.priceperkg;
                                                      pricediff = Provider.of<
                                                                      Vegetable>(
                                                                  context,
                                                                  listen: false)
                                                              .listveg
                                                              .singleWhere((element) =>
                                                                  element
                                                                      .filepath ==
                                                                  product
                                                                      .filepath)
                                                              .priceperkg /
                                                          4;
                                                    });
                                                    setState(() {
                                                      if (qty > 1) {
                                                        if (qty == 750) {
                                                          qty = 1;
                                                          price +=
                                                              pricediff.toInt();
                                                        } else {
                                                          qty += 250;
                                                          price +=
                                                              pricediff.toInt();
                                                        }
                                                      } else {
                                                        print('its maximum');
                                                      }
                                                      Provider.of<Vegetable>(
                                                              context,
                                                              listen: false)
                                                          .updatecartvalue(
                                                              price,
                                                              index,
                                                              qty);
                                                      savecart();
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
                        ],
                      ),
                    );
                  },
                  itemCount: Provider.of<Vegetable>(context, listen: false)
                      .listcartlength,
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 60, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                            'Rs.${Provider.of<Vegetable>(context, listen: false).totalprice}'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 400,
                    color: Colors.lightGreen,
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          cartdata();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderSummary()));
                          Provider.of<Vegetable>(context, listen: false)
                              .deletelistcart();
                          savecart();
                        });
                      },
                      child: Text('Checkout'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
