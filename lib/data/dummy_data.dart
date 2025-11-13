import '../models/menu_item.dart';

// --- DUMMY DATA with High-Quality Image URLs ---
// Using simpler, reliable Pexels/Unsplash links.

final List<MenuItem> dummyMenu = [
  MenuItem(
    id: '1',
    name: 'Spicy Veggie Burger',
    description: 'A juicy patty topped with fresh jalapeños and signature sauce.',
    price: 9.99,
    // Burger
    imageUrl: 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  MenuItem(
    id: '2',
    name: 'Signature Pasta Alfredo',
    description: 'Creamy Alfredo sauce with sun-dried tomatoes and basil.',
    price: 14.50,
    // Pasta
    imageUrl: 'https://images.pexels.com/photos/1487511/pexels-photo-1487511.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  MenuItem(
    id: '3',
    name: 'Truffle Fries',
    description: 'Crispy fries tossed in truffle oil and Parmesan cheese.',
    price: 6.00,
    // Fries
    imageUrl: 'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  MenuItem(
    id: '4',
    name: 'Classic Margherita Pizza',
    description: 'Fresh mozzarella, basil, and San Marzano tomatoes.',
    price: 18.00,
    // Pizza
    imageUrl: 'https://images.pexels.com/photos/1149022/pexels-photo-1149022.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  MenuItem(
    id: '5',
    name: 'Chocolate Lava Cake',
    description: 'Warm, gooey chocolate cake with a molten center, served with vanilla ice cream.',
    price: 8.50,
    // Dessert
    imageUrl: 'https://images.pexels.com/photos/291528/pexels-photo-291528.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
];