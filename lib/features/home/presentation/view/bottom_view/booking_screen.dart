import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var allBooking;
  double? proximityValue = 1.0; // Store proximity value
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("The Beauty Aesthetics"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Confirmed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              BookingList(status: "Pending"),
              BookingList(status: "Confirmed"),
              BookingList(status: "Cancelled"),
            ],
          ),
        ),
        // ... your BottomNavigationBar code ...
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
      ),
    );
  }
}

class BookingList extends StatefulWidget {
  final String status;
  const BookingList({super.key, required this.status});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  Future<dynamic> fetchBookings(String status) async {
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
      var allBooking = data["data"];
      // Filter bookings by status (case-insensitive)
      var filteredBookings = allBooking
          .where((booking) =>
              (booking['status'] ?? '').toLowerCase() == status.toLowerCase())
          .toList();
      return filteredBookings;
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    String? token = ApiEndpoints.accessToken;
    final url = Uri.parse('${ApiEndpoints.cancelBooking}/$bookingId');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Cancellation successful
      return true;
    } else {
      // Handle error or failure
      return false;
    }
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await fetchBookings(widget.status);
        },
        child: FutureBuilder(
          future: fetchBookings(widget.status),
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
                    title: Text(
                      bookService['title'] ?? 'Service not available',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${booking['bookingDate'] ?? "N/A"}\nTime: ${booking['bookingTime']}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Status: ${booking['status'] ?? "N/A"}',
                          style: TextStyle(
                            color: getColor(booking['status']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Show Cancel button only if status is Pending
                        if ((booking['status'] ?? '').toLowerCase() ==
                            'pending')
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Cancellation'),
                                      content: Text(
                                        'Are you sure you want to delete this ${bookService['title']}?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pop(); // Close dialog first

                                            // Show a loading indicator (optional)
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) => const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );

                                            bool success = await cancelBooking(
                                                booking['_id']);

                                            Navigator.of(context)
                                                .pop(); // Close loading indicator

                                            if (success) {
                                              setState(() {
                                                bookService
                                                    .remove(booking['_id']);
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        '${bookService['title']} cancelled!')),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Failed to cancel ${bookService['title']}')),
                                              );
                                            }
                                          },
                                          child: const Text('Yes'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Cancel Booking'),
                            ),
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
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_not_supported,
                                    size: 50, color: Colors.grey);
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
    );
  }
}
