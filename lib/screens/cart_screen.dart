import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_model.dart';
import 'main_screen.dart'; // Import to access navigation method

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () {
              _showClearCartDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty. Time to order!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('${cartItem.quantity}x', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(cartItem.item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Unit Price: \$${cartItem.item.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                              onPressed: () => cart.removeItem(cartItem.item.id), // Tap to remove quickly
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Checkout Summary
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(
                          '\$${cart.cartTotal.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: primaryColor),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    // Payment Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleCheckout(context, cart, false), // COD
                            icon: const Icon(Icons.delivery_dining),
                            label: const Text('Cash on Delivery'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              backgroundColor: Theme.of(context).colorScheme.secondary, // Yellow
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleCheckout(context, cart, true), // Online Payment
                            icon: const Icon(Icons.credit_card),
                            label: const Text('Secure Payment'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear Cart?'),
          content: const Text('This will remove all items. Are you sure?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Clear All', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).clearCart();
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cart cleared!'), backgroundColor: Theme.of(context).primaryColor),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _handleCheckout(BuildContext context, CartModel cart, bool isOnlinePayment) async {
    // Show a loading indicator (non-blocking dialog)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
      },
    );

    final success = await cart.checkout(isOnlinePayment);

    // Close the loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    String message;
    Color color;

    if (success) {
      message = isOnlinePayment ? 'Payment Successful! Your order has been placed.' : 'Order Placed! Thank you for choosing Cash on Delivery.';
      color = Colors.green;
    } else {
      message = isOnlinePayment ? 'Payment Failed. Please try COD or another method.' : 'Checkout Failed. Please try again.';
      color = Colors.red;
    }

    // Show a final status message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
        ),
      );
    }


    // Navigate back to the home screen on success
    if (success) {
      if (context.mounted) {
        // Use the custom method in MainScreen state to navigate
        final mainScreenState = context.findAncestorStateOfType<State<MainScreen>>();
        if (mainScreenState is MainScreenState) {
          mainScreenState.navigateToHome();
        }
      }
    }
  }
}