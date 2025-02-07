import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/dashboard_cubit.dart';

// Define DashboardTab

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.indigo,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Hotelify!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Book your perfect stay effortlessly.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(
                  context,
                  icon: Icons.hotel,
                  label: 'Rooms',
                  onTap: () {
                    // Navigate to Rooms page
                  },
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.history,
                  label: 'Bookings',
                  onTap: () {
                    // Navigate to Bookings History
                  },
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.local_offer,
                  label: 'Offers',
                  onTap: () {
                    // Navigate to Offers page
                  },
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.support_agent,
                  label: 'Support',
                  onTap: () {
                    // Navigate to Customer Support
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Featured Rooms Section
            const Text(
              'Featured Rooms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFeaturedRoomCard(
                    imagePath: 'assets/images/deluxe1.jpg',
                    roomName: 'Deluxe Room',
                    price: '\$120/night',
                  ),
                  _buildFeaturedRoomCard(
                    imagePath: 'assets/images/nondeluxe1.jpg',
                    roomName: 'Non-Deluxe Room',
                    price: '\$80/night',
                  ),
                  _buildFeaturedRoomCard(
                    imagePath: 'assets/images/suite1.jpg',
                    roomName: 'Suite Room',
                    price: '\$200/night',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Cards
            const Text(
              'Explore More',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildNavigationCard(
              icon: Icons.settings,
              title: 'Manage Account',
              description: 'Update your profile and settings.',
              onTap: () {
                // Navigate to Manage Account
              },
            ),
            _buildNavigationCard(
              icon: Icons.info,
              title: 'About Us',
              description: 'Learn more about our services.',
              onTap: () {
                // Navigate to About Us page
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build Quick Action buttons
  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.indigo,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Helper method to build Featured Room Cards
  Widget _buildFeaturedRoomCard({
    required String imagePath,
    required String roomName,
    required String price,
  }) {
    return Card(
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build Navigation Cards
  Widget _buildNavigationCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> screens = [
      DashboardTab(),
      BookingsTab(),
      ProfileTab(),
      ServiceTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotel Booking App",
          style: TextStyle(fontFamily: 'Roboto-Italic'),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return screens[state.currentIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<DashboardCubit>().changeTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_online),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                label: 'Service',
              ),
            ],
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          );
        },
      ),
    );
  }
}

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  BookingsTabState createState() => BookingsTabState();
}

class BookingsTabState extends State<BookingsTab> {
  List<Map<String, String>> displayedRooms = [];
  final List<Map<String, String>> deluxeRooms = [
    {
      'name': 'Deluxe Room 1',
      'image': 'lib/assets/images/deluxe1.jpg',
      'price': '150 USD'
    },
    {
      'name': 'Deluxe Room 2',
      'image': 'lib/assets/images/deluxe2.jpg',
      'price': '160 USD'
    },
    {
      'name': 'Deluxe Room 3',
      'image': 'lib/assets/images/deluxe3.jpg',
      'price': '170 USD'
    },
  ];
  final List<Map<String, String>> nonDeluxeRooms = [
    {
      'name': 'Non-Deluxe Room 1',
      'image': 'lib/assets/images/nondeluxe1.jpg',
      'price': '100 USD'
    },
    {
      'name': 'Non-Deluxe Room 2',
      'image': 'lib/assets/images/nondeluxe2.jpg',
      'price': '110 USD'
    },
    {
      'name': 'Non-Deluxe Room 3',
      'image': 'lib/assets/images/nondeluxe3.jpg',
      'price': '120 USD'
    },
  ];

  @override
  void initState() {
    super.initState();
    displayedRooms = deluxeRooms; // Default view is Deluxe Rooms
  }

  void _selectDeluxe() {
    setState(() {
      displayedRooms = deluxeRooms;
    });
  }

  void _selectNonDeluxe() {
    setState(() {
      displayedRooms = nonDeluxeRooms;
    });
  }

  void _bookRoom(String roomName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$roomName has been booked successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Bookings',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Search Bar
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search Rooms',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                displayedRooms = [...deluxeRooms, ...nonDeluxeRooms]
                    .where((room) => room['name']!
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              });
            },
          ),
          const SizedBox(height: 20),
          // Filter Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _selectDeluxe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Deluxe Rooms'),
              ),
              ElevatedButton(
                onPressed: _selectNonDeluxe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Non-Deluxe Rooms'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Available Rooms',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Room List
          Expanded(
            child: ListView.builder(
              itemCount: displayedRooms.length,
              itemBuilder: (context, index) {
                final room = displayedRooms[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Room Image
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(room['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Room Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Price: ${room['price']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => _bookRoom(room['name']!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Book Now'),
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
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            const Center(
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  // Name and Email
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Account Details
            const Text(
              'Account Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Membership Status'),
                subtitle: Text('Gold Member'),
              ),
            ),
            const Card(
              margin:  EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading:  Icon(Icons.card_giftcard, color: Colors.green),
                title:  Text('Loyalty Points'),
                subtitle:  Text('2,450 Points'),
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildActionCard(
              context,
              icon: Icons.edit,
              title: 'Edit Profile',
              description: 'Update your personal information.',
              onTap: () {
                // Navigate to Edit Profile
              },
            ),
            _buildActionCard(
              context,
              icon: Icons.history,
              title: 'Booking History',
              description: 'View your previous bookings.',
              onTap: () {
                // Navigate to Booking History
              },
            ),
            _buildActionCard(
              context,
              icon: Icons.lock,
              title: 'Account Settings',
              description: 'Manage your account and privacy.',
              onTap: () {
                // Navigate to Account Settings
              },
            ),
            const SizedBox(height: 20),

            // Logout Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle Logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build action cards
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class ServiceTab extends StatelessWidget {
  const ServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Available Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Service Cards
            _buildServiceCard(
              context,
              icon: Icons.room_service,
              title: 'Room Service',
              description: 'Order food and beverages to your room.',
              onTap: () {
                // Handle Room Service Booking
              },
            ),
            _buildServiceCard(
              context,
              icon: Icons.spa,
              title: 'Spa & Wellness',
              description: 'Relax with our exclusive spa treatments.',
              onTap: () {
                // Handle Spa Booking
              },
            ),
            _buildServiceCard(
              context,
              icon: Icons.restaurant,
              title: 'Dining Options',
              description: 'Explore our in-house restaurants and menus.',
              onTap: () {
                // Navigate to Dining Options
              },
            ),
            _buildServiceCard(
              context,
              icon: Icons.cleaning_services,
              title: 'Room Cleaning',
              description: 'Request room cleaning and maintenance.',
              onTap: () {
                // Request Room Cleaning
              },
            ),
            _buildServiceCard(
              context,
              icon: Icons.pool,
              title: 'Recreational Facilities',
              description: 'Book access to the pool, gym, and more.',
              onTap: () {
                // Handle Recreation Facility Booking
              },
            ),

            const SizedBox(height: 20),

            // Contact Support
            const Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Handle Contact Support
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
              ),
              icon: const Icon(Icons.phone),
              label: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build service cards
  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          child: const Text('Book'),
        ),
      ),
    );
  }
}
