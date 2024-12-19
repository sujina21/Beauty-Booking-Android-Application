import 'package:flutter/material.dart';
import 'package:sprint_1/view/dashboard_screen.dart';
class NailsScreen extends StatelessWidget {
  const NailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nail Services Data
    final List<Map<String, String>> nailServices = [
      {
        'image': 'lib/assets/image/gel_chrome.jpg',
        'type': 'Gel Nails',
        'art': 'Chrome Nail Art',
        'price': 'NRS 2000'
      },
      {
        'image': 'lib/assets/image/acrylic_flower.jpg',
        'type': 'Acrylic Nails',
        'art': 'Flower Nail Art',
        'price': 'NRS 2500'
      },
      {
        'image': 'lib/assets/image/gel_christmas.jpg',
        'type': 'Gel Nails',
        'art': 'Christmas Nail Art',
        'price': 'NRS 2200'
      },
      {
        'image': 'lib/assets/image/acrylic_chrome.jpg',
        'type': 'Acrylic Nails',
        'art': 'Chrome Nail Art',
        'price': 'NRS 2400'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nails Services"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back Button Icon
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore Nail Services",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: nailServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final nail = nailServices[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image Section
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              nail['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Details Section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                nail['type']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                nail['art']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                nail['price']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
