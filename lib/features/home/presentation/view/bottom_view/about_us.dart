import 'package:flutter/material.dart';
import 'package:sprint_1/features/home/presentation/view/bottom_view/favourite_page.dart';
import 'package:sprint_1/features/home/presentation/view/bottom_view/profile_screen.dart';
import 'package:sprint_1/features/home/presentation/view/home_view.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "The Beauty Aesthetics" Info Section
              Text(
                'The Beauty Aesthetics',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'We are a beauty service provider offering personalized beauty treatments tailored to each individual’s needs. Our goal is to make you feel pampered and beautiful.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Cards related to "The Beauty Aesthetics"
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.pink),
                  title: Text('Why Us?'),
                  subtitle: Text(
                      'Experience personalized services for every individual.'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.green),
                  title: Text('What Products Do We Use?'),
                  subtitle:
                      Text('We use premium, dermatologically tested products.'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.blue),
                  title: Text('Why Join Our Makeup and Nails Courses?'),
                  subtitle: Text(
                      'Learn from industry experts and kickstart your career!'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.thumb_up, color: Colors.orange),
                  title: Text('Why We’re The Best In Town?'),
                  subtitle: Text(
                      'Our services are tailored to your specific needs, making us stand out.'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2, // About Us screen index for bottom navigation
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
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavouriteScreen(),
            ),
          );
        } else if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
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
