import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../state/cart_model.dart';
import '../data/dummy_data.dart'; // <<< IMPORT CENTRAL DATA HERE

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Delicious Menu'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: dummyMenu.length, // <<< USES CENTRALIZED LIST
        itemBuilder: (context, index) {
          final item = dummyMenu[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      // Fallback in case image fails to load
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 100,
                        color: primaryColor.withOpacity(0.3),
                        child: Icon(Icons.fastfood, color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Item Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(item.description, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 8),
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Add to Cart Button
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2)),
                        ]
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                        onPressed: () {
                          cartModel.addItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} added to cart!'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}