import 'package:commerce/data/vegetable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  void initState() {
    super.initState();
    gettotal();
  }

  double total = 0;

  void gettotal() {
    int amount = 0;
    //int length =
    //   Provider.of<Vegetable>(context, listen: false).checkoutitemlength;
    setState(() {
      for (int i = 0;
          i < Provider.of<Vegetable>(context, listen: false).checkoutitemlength;
          i++) {
        amount += Provider.of<Vegetable>(context, listen: false)
            .checkoutitem[i]
            .priceperkg;
      }
      total = amount.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Order Summary'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  alignment: Alignment.center,
                  color: Colors.lime[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Provider.of<Vegetable>(context, listen: false)
                                    .checkoutitemlength !=
                                0
                            ? 'We received your order Congrats!'
                            : 'Sorry! You have no order!',
                        style: TextStyle(
                            color:
                                Provider.of<Vegetable>(context, listen: false)
                                            .checkoutitemlength !=
                                        0
                                    ? Colors.black
                                    : Colors.red),
                      ),
                      Text(
                          'Total items:${Provider.of<Vegetable>(context, listen: false).checkoutitemlength}'),
                    ],
                  )),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final product = Provider.of<Vegetable>(context, listen: false)
                      .checkoutitem[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                      child: Text(
                                          'Qty.${product.quantity}${product.quantity == 1 ? 'kg' : 'gm'}'),
                                    )
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
                    .checkoutitemlength,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Total amount: Rs.$total'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
