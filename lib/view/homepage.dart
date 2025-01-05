// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; // Import get_it for dependency injection
import 'package:sprint_1/services/dashboard_service.dart'; // Import the service
import 'package:sprint_1/view/about_us.dart';
import 'package:sprint_1/view/favourite_page.dart';

import 'makeup_screen.dart';
import 'nails_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final DashboardService _dashboardService =
      GetIt.instance<DashboardService>(); // Inject DashboardService

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const AboutUsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 242, 242),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            _buildServicesSection(context),
            const SizedBox(height: 20),
            _buildClassesSection(context),
            const SizedBox(height: 20),
            _buildExploreMore(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Row(
            children: [
              ZoomIn(
                duration: const Duration(seconds: 1),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/image/makeup.jpg'),
                ),
              ),
              const SizedBox(width: 20),
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Sujina!', // You can use dynamic data here
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Are you ready to explore the world of beauty?',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(179, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              _buildServiceCard(
                context,
                'Makeup Services',
                'Explore professional makeup artistry services.',
                const MakeupScreen(),
                'assets/image/makeup.jpg',
              ),
              _buildServiceCard(
                context,
                'Nail Services',
                'Pamper your nails with expert care.',
                const NailsScreen(),
                'assets/image/nails.jpg',
              ),
            ],
          )
        ],
      ),
    );
  }

  // Other widget methods remain unchanged...
  // (You can continue implementing _buildServiceCard, _buildClassesSection, etc.)
}

Widget _buildServiceCard(
  BuildContext context,
  String title,
  String description,
  Widget destinationScreen,
  String imagePath,
) {
  return FadeInUp(
    duration: const Duration(milliseconds: 600),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // Removed the image path for services.jpg
            child: Image.asset(imagePath,
                width: 60, height: 60, fit: BoxFit.cover),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    ),
  );
}

Widget _buildClassesSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Courses We Offer',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            _buildClassCard(
              '3 days Nails Workshop',
              'Learn trending nail art techniques for a perfect foundation.',
              'assets/image/workshop.jpg',
              Colors.pink[50],
            ),
            _buildClassCard(
              'Basic Nails Course',
              'Learn basic nail art techniques for your own self.',
              'assets/image/basicn.jpg',
              Colors.pink[50],
            ),
            _buildClassCard(
              'Basic Makeup Course',
              'Understand the fundamentals of makeup artistry.',
              'assets/image/basicm.jpg',
              Colors.blue[50],
            ),
            _buildClassCard(
              'Advanced Nails Class',
              'Master advanced techniques for nail art.',
              'assets/image/advn.jpg',
              Colors.orange[50],
            ),
            _buildClassCard(
              'Professional Nails Class',
              'Become a professional in nail care and art.',
              'assets/image/pron.jpg',
              Colors.green[50],
            ),
            _buildClassCard(
              'Professional Makeup Class',
              'Advance your skills to become a makeup professional.',
              'assets/image/prom.jpg',
              Colors.purple[50],
            ),
            _buildClassCard(
              'Masters Nails class',
              'Join our masterclass to excel in nail art and care.',
              'assets/image/master.jpg',
              Colors.red[50],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildClassCard(String title, String description, String imagePath,
    Color? backgroundColor) {
  return FadeInUp(
    duration: const Duration(milliseconds: 600),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:
              Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
    ),
  );
}

Widget _buildExploreMore(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        // Add navigation logic to explore more classes or features
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Text(
          'Explore More',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget _buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: 0,
    selectedItemColor: Colors.pinkAccent,
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_pin_circle_outlined), label: 'About Us'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    onTap: (index) {
      if (index == 0) {
        // Stay on the home page
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavouriteScreen()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutUsScreen()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    },
  );
}
