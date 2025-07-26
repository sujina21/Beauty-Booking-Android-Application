import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Initial user details
  String name = 'Jess Gill';
  String email = 'jess77@gmail.com';
  String phone = '1234509876';
  String location = 'House no 502, Grande towers';
  String gender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Sign In page
            },
            child: Text('Sign In', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to Sign Up page
            },
            child: Text('Sign Up', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Personal Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildTextField('Name', name, (value) => name = value),
              _buildTextField('Email', email, (value) => email = value),
              _buildTextField('Phone', phone, (value) => phone = value),
              _buildTextField(
                  'Location', location, (value) => location = value),
              _buildTextField('Gender', gender, (value) => gender = value),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Changes Saved')),
                    );
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Profile Page selected
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation
          // Example: if (index == 0) { Navigator.push(...); }
        },
      ),
    );
  }

  Widget _buildTextField(
      String label, String initialValue, Function(String) onSave) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          if (value != null) onSave(value);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
