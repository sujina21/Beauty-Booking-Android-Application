import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import for shake detection

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var allBooking;
  double? proximityValue = 0.0; // Store proximity value
  final int _selectedIndex = 1;
  bool isShaking = false;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Prevent unnecessary reload

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const DashboardScreen();
        break;
      case 1:
        return; // Stay on the same screen
      case 2:
        nextScreen = const AboutUsScreen();
        break;
      case 3:
        nextScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  // Function to fetch bookings from the API
  Future<dynamic> fetchBookings() async {
    String? token = ApiEndpoints.accessToken;
    final response = await http.get(
      Uri.parse(ApiEndpoints.allUserBooking),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      allBooking = data["data"];
      return allBooking;
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  // Shake detection
  void detectShake() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      double shakeThreshold = 12; // Customize sensitivity
      if ((x.abs() + y.abs() + z.abs()) > shakeThreshold && !isShaking) {
        setState(() {
          isShaking = true;
        });

        // Trigger refresh or any other action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shake Detected! Refreshing data...')),
        );

        // Call your refresh function (optional)
        fetchBookings().then((value) {
          setState(() {
            isShaking = false;
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    detectShake();
    detectProximity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to detect proximity sensor value and show color-changing dialog
  void detectProximity() {
    // Listen to the proximity sensor events
    ProximitySensor.events.listen((event) {
      print("Event value --> $event");
      setState(() {
        proximityValue = event.toDouble(); // Store proximity value
      });

      // Show a dialog with dynamic background color based on proximity
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Proximity Sensor Alert'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Proximity Value: ${proximityValue!.toStringAsFixed(2)}'),
              ],
            ),
            backgroundColor: getBackgroundColor(
                proximityValue!), // Get color based on proximity value
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    });
  }

  // Function to return a background color based on proximity value
  Color getBackgroundColor(double proximityValue) {
    if (proximityValue < 5.0) {
      return Colors.green; // Near user, green color
    } else if (proximityValue < 10.0) {
      return Colors.yellow; // Medium distance, yellow color
    } else {
      return Colors.red; // Far away, red color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("The Beauty Aesthetics")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Your Upcoming Bookings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await fetchBookings();
                },
                child: FutureBuilder(
                  future: fetchBookings(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No bookings available"));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var booking = snapshot.data![index];
                        var bookService = booking["serviceId"];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              bookService['title'] ?? 'Service not available',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Date: ${booking['bookingDate'] ?? "N/A"}\nTime:${booking['bookingTime']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  'Status: ${booking['status'] ?? "N/A"}',
                                  style: TextStyle(
                                      color: getColor(booking['status']),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: booking['serviceId']['image'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      booking['serviceId']['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.grey);
                                      },
                                    ),
                                  )
                                : const Icon(Icons.image_not_supported,
                                    size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'About Us'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Color getColor(String bookingStatus) {
    Color color;
    if (bookingStatus.toLowerCase() == "Pending".toLowerCase()) {
      color = Colors.orange;
    } else if (bookingStatus.toLowerCase() == "Confirmed".toLowerCase()) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    return color;
  }
}
