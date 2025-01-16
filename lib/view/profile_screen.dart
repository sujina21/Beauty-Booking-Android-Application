import 'package:flutter/material.dart';
import 'package:sprint_1/features/auth/login_screen.dart';
import 'package:sprint_1/view/about_us.dart';
import 'package:sprint_1/view/dashboard_screen.dart';
import 'package:sprint_1/view/favourite_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _appointmentReminders = true;
  bool _newServiceAlerts = true;
  bool _isProfileCompleted = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int _selectedIndex = 3; // Profile screen index for bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink[50],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              const Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage('assets/image/makeup.jpg'),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sujina Shrestha',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "sujinast307@gmail.com",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Welcome Message
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Complete your profile to book your first appointment.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Setup Reminder
              const SizedBox(height: 10),
              !_isProfileCompleted
                  ? Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isProfileCompleted = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        icon: const Icon(Icons.check_circle,
                            size: 20, color: Colors.white),
                        label: const Text('Complete Profile',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Edit Profile Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(_nameController, 'Name'),
                        const SizedBox(height: 10),
                        _buildTextField(_emailController, 'Email'),
                        const SizedBox(height: 10),
                        _buildTextField(_emailController, 'Phone Number'),
                        const SizedBox(height: 10),
                        _buildTextField(_emailController, 'Address'),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isProfileCompleted = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                            ),
                            child: const Text("Save Profile",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),

              // Upcoming Appointments
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Upcoming Appointments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: ListTile(
                  title: Text('Glam Part Makeup'),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/image/makeup.jpg'),
                  ),
                  subtitle: Text('January 26, 2025 at 2:00 PM'),
                ),
              ),
              const SizedBox(height: 20),

              // Notification Preferences
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Notification Preferences',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile(
                title: const Text('Appointment Reminders'),
                value: _appointmentReminders,
                onChanged: (bool value) {
                  setState(() {
                    _appointmentReminders = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('New Service Alerts'),
                value: _newServiceAlerts,
                onChanged: (bool value) {
                  setState(() {
                    _newServiceAlerts = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Invite a Friend Program
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Invite a Friend',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: ListTile(
                  leading: Icon(Icons.share, color: Colors.blue),
                  title: Text('Share Your Referral Code'),
                  subtitle: Text('Earn discounts on your next booking.'),
                ),
              ),
              const SizedBox(height: 20),

              // Getting Started Checklist
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Getting Started Checklist',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const ChecklistItem(label: '• Complete your profile'),
              const ChecklistItem(label: '• Book your first service'),
              const ChecklistItem(label: '• Explore available courses'),
              const SizedBox(height: 20),

              // Special Offers
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Special Offers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: ListTile(
                  leading: Icon(Icons.local_offer, color: Colors.red),
                  title: Text('10% off your first appointment!'),
                ),
              ),
              const SizedBox(height: 20),

              // Logout Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                  ),
                  icon: const Icon(Icons.logout, size: 20, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
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
      currentIndex: _selectedIndex,
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
        setState(() {
          _selectedIndex = index; // Update selected index
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavouriteScreen(),
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
        } else if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      },
    );
  }

  // Text field builder function
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

// ChecklistItem widget
class ChecklistItem extends StatelessWidget {
  final String label;
  const ChecklistItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.pink, size: 18),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}
