import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/auth/presentation/view/login_view.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/booking_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
                            backgroundImage: AssetImage('assets/images/me.png'),
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
                              "sujinasht@gmail.com",
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
                    color: Color.from(
                        alpha: 1, red: 0.914, green: 0.118, blue: 0.388),
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
              const SizedBox(height: 10),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.black38,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => showChangePasswordDialog(context),
                child: const Card(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                  child: ListTile(
                      leading: Icon(Icons.lock, color: Colors.blue),
                      title: Text('Click here to change password')),
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.black38,
              ),
              const SizedBox(height: 10),
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
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.black38,
              ),
              const SizedBox(height: 10),
              // Notification Preferences

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
              const SizedBox(height: 10.0),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.black38,
              ),
              const SizedBox(height: 10),
              // Notification Preferences

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
              const SizedBox(height: 10.0),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.black38,
              ),
              const SizedBox(height: 10),
              // Notification Preferences

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
                  onPressed: () async {
                    // Clear the stored login data (e.g., token)
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove(
                        'auth_token'); // Replace 'auth_token' with your key

                    // Optionally, you can also remove other user data
                    await prefs.remove('user_email');
                    await prefs.remove('user_name');

                    // Navigate to Login Screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
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
              )
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

Future<bool> changePassword({
  required String oldPassword,
  required String newPassword,
}) async {
  final url = Uri.parse(ApiEndpoints.changePassword);
  String? token = ApiEndpoints.accessToken;
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    },
    body: jsonEncode({
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    }),
  );

  if (response.statusCode == 200) {
    // Password reset successful
    Map<String, dynamic> result = json.decode(response.body);
    return result["success"];
  } else {
    // Handle error or failure
    return false;
  }
}

void showChangePasswordDialog(BuildContext context) {
  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Center(
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Old Password Field
                  TextFormField(
                    controller: oldPasswordController,
                    obscureText: !isOldPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isOldPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isOldPasswordVisible = !isOldPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // New Password Field
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: !isNewPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isNewPasswordVisible = !isNewPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Change Password Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        // Check for empty fields
                        if (oldPasswordController.text.isEmpty ||
                            newPasswordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All fields are required.'),
                            ),
                          );
                          return;
                        }

                        // Check if new password and confirm password match
                        if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match.'),
                            ),
                          );
                          return;
                        }

                        // Proceed with password change API call
                        bool result = await changePassword(
                          oldPassword: oldPasswordController.text,
                          newPassword: confirmPasswordController.text,
                        );

                        if (result) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password changed successfully!'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Incorrect old password. Please try again.'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
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
