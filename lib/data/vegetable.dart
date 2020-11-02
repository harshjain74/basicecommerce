import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'model.dart';

class Vegetable with ChangeNotifier {
  List<Model> _listveg = [];
  List<Model> _listcart = [];
  List<Model> _checkout = [];

  void checkout(List<Model> model) {
    _checkout = model;

    notifyListeners();
  }

  void deletelistcart() {
    _listcart.removeRange(0, _listcart.length);
    _totalprice = 0;
    notifyListeners();
  }

  get checkoutitem {
    return _checkout;
  }

  get listcartlength {
    return _listcart.length;
  }

  get checkoutitemlength {
    return _checkout.length;
  }

  get length {
    return _listveg.length;
  }

  int _totalprice = 0;

  get totalprice {
    return _totalprice;
  }

  void gettotal(List<Model> model) {
    _totalprice = 0;
    for (int i = 0; i < model.length; i++) {
      _totalprice += _listcart[i].priceperkg;
      notifyListeners();
    }
  }

  UnmodifiableListView<Model> get listveg {
    return UnmodifiableListView(_listveg);
  }

  void updatecartvalue(int price, int index, int qty) {
    _listcart[index].priceperkg = price;

    if (_listcart[index].priceperkg == 0) {
      _listcart.removeAt(index);
    } else {
      _listcart[index].quantity = qty;
    }
    gettotal(_listcart);
    notifyListeners();
  }

  UnmodifiableListView<Model> get listcart {
    return UnmodifiableListView(_listcart);
  }

  void addcart(String path, int price, int quantity, String name) {
    final veg = Model(path, price, quantity, name);
    _listcart.add(veg);
    notifyListeners();
  }

  void updatecart(List<Model> models) {
    _listcart = models;
    notifyListeners();
  }

  void addvegetable(String path, int price, int quantity, String name) {
    final veg = Model(path, price, quantity, name);
    _listveg.add(veg);
    notifyListeners();
  }
}
