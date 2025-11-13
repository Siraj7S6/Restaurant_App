import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get cartTotal {
    return _items.fold(0.0, (sum, current) => sum + current.totalPrice);
  }

  void addItem(MenuItem item) {
    int index = _items.indexWhere((i) => i.item.id == item.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(item: item));
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.item.id == itemId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Simulated Payment/Checkout Logic
  Future<bool> checkout(bool isOnlinePayment) async {
    if (_items.isEmpty) return false;

    if (isOnlinePayment) {
      // Simulate a network delay for the online transaction
      await Future.delayed(const Duration(seconds: 2));

      // 80% chance of success for demonstration
      final success = DateTime.now().millisecondsSinceEpoch % 10 < 8;

      if (success) {
        clearCart();
        return true; // Payment success
      } else {
        return false; // Payment failed
      }
    } else {
      // Cash on Delivery (COD) - always successful on the app side
      clearCart();
      return true;
    }
  }
}