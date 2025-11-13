import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Placeholder data
  final String restaurantEmail = 'contact@flavourfusion.com';
  final String restaurantPhone = '+1 (555) 123-4567';

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are here to answer any questions you may have about our menu, your order, or reservations.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // Email Card
            Card(
              elevation: 6, // Increased elevation
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.email_outlined, color: primaryColor, size: 30),
                ),
                title: const Text('Send us an Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text(restaurantEmail, style: const TextStyle(fontSize: 15)),
                trailing: Icon(Icons.chevron_right, color: primaryColor),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Simulating sending email to $restaurantEmail')),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Phone Card
            Card(
              elevation: 6, // Increased elevation
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.phone_outlined, color: primaryColor, size: 30),
                ),
                title: const Text('Call our Hotline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text(restaurantPhone, style: const TextStyle(fontSize: 15)),
                trailing: Icon(Icons.chevron_right, color: primaryColor),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Simulating calling $restaurantPhone')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}