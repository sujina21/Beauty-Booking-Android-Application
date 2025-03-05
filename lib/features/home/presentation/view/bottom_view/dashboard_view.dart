import 'package:animate_do/animate_do.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/booking_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/nails_screen.dart';
import 'package:flutter/material.dart';

import 'makeup_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  final List<Map<String, String>> BookingServices = [
    {
      'service': 'Makeup',
      'description': 'Explore professional makeup services'
    },
    {'service': 'Nails', 'description': 'Pamper your nails with expert care'},
  ];

  final List<Widget> pages = [
    const DashboardScreen(), // You can customize this if needed
    const BookingScreen(),
    const AboutUsScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "The Beauty Aesthetics",
          style: TextStyle(fontSize: 25),
        ),
      ),
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
                  backgroundImage: AssetImage('assets/images/makeup.jpg'),
                ),
              ),
              const SizedBox(width: 20),
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Sujina!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Let's start your beauty journey together!",
                      style: TextStyle(fontSize: 12, color: Colors.white70),
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
                'assets/images/makeup.jpg', // Image for Makeup Services
              ),
              _buildServiceCard(
                context,
                'Nail Services',
                'Pamper your nails with expert care.',
                const NailScreen(),
                'assets/images/nails.jpg', // Image for Nail Services
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String description,
    Widget destinationScreen,
    String imagesPath,
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
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagesPath,
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
                'assets/images/nails.jpg',
                Colors.pink[50],
              ),
              _buildClassCard(
                'Basic Nails Course',
                'Learn basic nail art techniques for your own self.',
                'assets/images/nails.jpg',
                Colors.pink[50],
              ),
              _buildClassCard(
                'Basic Makeup Course',
                'Understand the fundamentals of makeup artistry.',
                'assets/images/makeup.jpg',
                Colors.blue[50],
              ),
              _buildClassCard(
                'Advanced Nails Class',
                'Master advanced techniques for nail art.',
                'assets/images/nails.jpg',
                Colors.orange[50],
              ),
              _buildClassCard(
                'Professional Nails Class',
                'Become a professional in nail care and art.',
                'assets/images/nails.jpg',
                Colors.green[50],
              ),
              _buildClassCard(
                'Professional Makeup Class',
                'Advance your skills to become a makeup professional.',
                'assets/images/makeup.jpg',
                Colors.purple[50],
              ),
              _buildClassCard(
                'Masters Nails class',
                'Join our masterclass to excel in nail art and care.',
                'assets/images/nails.jpg',
                Colors.red[50],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(String title, String description, String imagesPath,
      Color? backgroundColor) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagesPath,
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
        BottomNavigationBarItem(
            icon: Icon(Icons.book_online), label: 'Bookings'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle_outlined), label: 'About Us'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        if (index == 1) {
          // Pass the BookingServices list when navigating to BookingScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookingScreen(),
            ),
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
}
