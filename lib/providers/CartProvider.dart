import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DBHelper.dart';
import '../models/CartItem.dart';
import '../models/Product.dart';

class CartProvider with ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<CartItem> cart = [];

  CartProvider() {
    _setPrefsItems();
  }

  Future<void> addToCart(Product product, String size, int quantity) async {
    double surCharge = size == 's'
        ? 0
        : size == 'm'
            ? 6000
            : 10000;
    CartItem cartItem = CartItem(
      product_id: product.id,
      name: product.name,
      image: product.image,
      size: size,
      quantity: ValueNotifier(quantity),
      price: product.price + surCharge,
    );
    CartItem? existCartItem = await dbHelper.getCartItem(product.id, size);
    if (existCartItem != null) {
      int newQuanity = quantity + existCartItem.quantity!.value;
      cartItem.quantity = ValueNotifier<int>(newQuanity);
      dbHelper.update(existCartItem.id, cartItem).then((value) {
        print('Update quantity');
      }).onError((error, stackTrace) {
        print(error.toString());
        return;
      });
    } else {
      dbHelper.insert(cartItem).then((value) {
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
        return;
      });
    }
    addTotalPrice(cartItem.price*quantity);
    addCounter(quantity);
  }

  Future<void> removeFromCart(int id) async {
    dbHelper.deleteCartItem(id).then((value) {
      if (value > 0) {
        removeItem(id);
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<List<CartItem>> getData() async {
    cart = await dbHelper.getCartList();
    notifyListeners();
    return cart;
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter(int quanity) {
    _counter += quantity;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter(int quantity) {
    _counter -= quantity;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity!.value = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    CartItem deleted = cart[index];
    cart.removeAt(index);
    removeCounter(deleted.quantity!.value);
    removeTotalPrice(deleted.price * deleted.quantity!.value);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }
}
