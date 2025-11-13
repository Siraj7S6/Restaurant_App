import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Primary Color for quick reference
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlavourFusion: Welcome'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 80.0), // Added bottom padding for navigation bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Hero Banner (More Professional Gradient/Shadow) ---
            Card(
              elevation: 8, // Increased elevation for depth
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.6)], // Cleaner gradient
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  boxShadow: [ // Elegant shadow
                    BoxShadow(
                      color: primaryColor.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Taste the Magic, Delivered.',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900, // Thicker font weight
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your next culinary adventure is just a tap away. Fresh ingredients, exquisite recipes, zero compromise.',
                      style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        // Action to navigate to Menu (handled by BottomNav, but nice to have)
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('View Full Menu', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- 2. About Us Section (Improved Typography) ---
            Text(
              'Our Culinary Journey',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: primaryColor),
            ),
            const SizedBox(height: 8),
            const Text(
              'FlavourFusion was born out of a simple passion: bringing restaurant-quality meals straight to your table. We focus on locally sourced, sustainable ingredients and traditional cooking methods to ensure every bite is an experience. From our famous Signature Pasta to our artisanal desserts, we pour our heart into every order. Order now and join the food revolution!',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 30),

            // --- 3. Feature Image Gallery (Updated with New URLs) ---
            Text(
              'Featured Delights',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: primaryColor),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 220, // Increased height slightly
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // High-quality plated meal
                  _buildImageCard(context, 'https://images.pexels.com/photos/1310777/pexels-photo-1310777.jpeg?auto=compress&cs=tinysrgb&w=800', 'Chef\'s Signature Plate'),
                  // High-quality bakery/bread shot
                  _buildImageCard(context, 'https://images.pexels.com/photos/103525/pexels-photo-103525.jpeg?auto=compress&cs=tinysrgb&w=800', 'Artisanal Bread Selection'),
                  // Restaurant Interior
                  _buildImageCard(context, 'https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=800', 'The Cozy Ambiance'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context, String url, String title) {
    return Container(
      width: 200, // Slightly wider card
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
              // Error builder shows a custom placeholder if the image fails to load
              errorBuilder: (context, error, stackTrace) {
                // If the images fail again, check the console for this print message.
                print('Image load failed for URL: $url. Error: $error');
                return Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Failed to Load: $title. Check network.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.black54, // Semi-transparent overlay
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}