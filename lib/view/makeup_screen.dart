import 'package:flutter/material.dart';
import 'package:sprint_1/view/dashboard_screen.dart';

class MakeupScreen extends StatelessWidget {
  const MakeupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Makeup Services Data
    final List<Map<String, String>> makeupServices = [
      {
        'image': 'assets/image/bridal_makeup.jpg',
        'type': 'Bridal Makeup',
        'description': 'Get a flawless bridal look on your special day.',
        'price': 'NRS 12,000'
      },
      {
        'image': 'assets/image/engagement_makeup.jpg',
        'type': 'Engagement Makeup',
        'description': 'Perfect makeup for your engagement ceremony.',
        'price': 'NRS 8,000'
      },
      {
        'image': 'assets/image/mehendi_makeup.jpg',
        'type': 'Mehendi Makeup',
        'description': 'Traditional makeup for your mehendi event.',
        'price': 'NRS 6,000'
      },
      {
        'image': 'assets/image/glam_party_makeup.jpg',
        'type': 'Glam Party Makeup',
        'description': 'Glamorous look for parties and events.',
        'price': 'NRS 5,000'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Makeup Services"),
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
              "Explore Makeup Services",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: makeupServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final makeup = makeupServices[index];
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
                              makeup['image']!,
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
                                makeup['type']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                makeup['description']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                makeup['price']!,
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
