import 'dart:convert';

import 'package:beauty_booking_app/app/constants/api_endpoints.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NailScreen extends StatefulWidget {
  const NailScreen({super.key});

  @override
  State<NailScreen> createState() => _NailScreenState();
}

class _NailScreenState extends State<NailScreen> {
  var allNail;
  Future<dynamic> getAllNail() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.nail));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        allNail = data["data"];
        return allNail;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getAllNail();
    super.initState();
  }

  /// Function to Open Date & Time Picker
  Future<void> openBookingPopup(BuildContext context, String serviceId,
      String serviceName, String amount) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    String appointmentPlace = "Studio"; // Default selection

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Date & Time"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(selectedDate == null
                        ? "Pick a Date"
                        : DateFormat('yyyy-MM-dd').format(selectedDate!)),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() => selectedDate = pickedDate);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(selectedTime == null
                        ? "Pick a Time"
                        : selectedTime!.format(context)),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() => selectedTime = pickedTime);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Where do you want your appointment?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Horizontal radio buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: "Home Service",
                            groupValue: appointmentPlace,
                            onChanged: (value) {
                              setState(() {
                                appointmentPlace = value!;
                              });
                            },
                          ),
                          const Text("Home Service"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Studio",
                            groupValue: appointmentPlace,
                            onChanged: (value) {
                              setState(() {
                                appointmentPlace = value!;
                              });
                            },
                          ),
                          const Text("Studio"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 30% upfront payment info in green
                  Text(
                    "40% upfront payment: Rs.${(double.tryParse(amount) ?? 0) * 0.4}",
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedDate == null || selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select date and time."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context);
                    await openEsewaPayment(
                        context: context,
                        serviceId: serviceId,
                        serviceName: serviceName,
                        serviceAmount: double.tryParse(amount) ?? 0,
                        selectedDate: selectedDate!,
                        selectedTime: selectedTime!,
                        appointmentPlace: appointmentPlace);
                  },
                  child: const Text("Pay Now"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handlePaymentFailure(BuildContext context, dynamic data) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Payment Failed: $data', style: theme.textTheme.bodyLarge),
        backgroundColor: Colors.red.shade400,
      ),
    );
  }

  void _handlePaymentCancellation(BuildContext context, dynamic data) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Payment Cancelled: $data', style: theme.textTheme.bodyLarge),
        backgroundColor: Colors.orange.shade400,
      ),
    );
  }

  Future<void> openEsewaPayment(
      {required BuildContext context,
      required String serviceId,
      required String serviceName,
      required double serviceAmount,
      required DateTime selectedDate,
      required TimeOfDay selectedTime,
      required String appointmentPlace}) async {
    try {
      // Calculate 40% upfront payment
      String upfront = (serviceAmount * 0.4).toStringAsFixed(2);

      // Create eSewa payment object
      final payment = EsewaPayment(
        productId: serviceId,
        productName: serviceName,
        productPrice: upfront,
        callbackUrl:
            'https://yourdomain.com/callback', // Replace with your callback URL or leave as is if not used
      );

      EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
            environment: Environment.test,
            clientId: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
            secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
          ),
          esewaPayment: payment,
          onPaymentSuccess: (EsewaPaymentSuccessResult result) async {
            bookService(
                serviceId, selectedDate, selectedTime, appointmentPlace);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Booking Confirmed!"),
              backgroundColor: Colors.green,
            ));
          },
          onPaymentFailure: (data) {
            _handlePaymentFailure(context, data);
          },
          onPaymentCancellation: (data) {
            _handlePaymentCancellation(context, data);
          });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// API Call to Book Service
  Future<void> bookService(String serviceId, DateTime date, TimeOfDay time,
      String appointmentPlace) async {
    // Format Date & Time
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String formattedTime =
        "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')}${time.period == DayPeriod.am ? "am" : "pm"}";

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.booking),
        headers: {
          'Authorization': 'Bearer ${ApiEndpoints.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "serviceId": serviceId,
          "serviceType": "Nail",
          "bookingDate": formattedDate,
          "bookingTime": formattedTime,
          "appointmentPlace": appointmentPlace
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Booking Successful!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to book service');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nail Services"),
        backgroundColor: Color.fromARGB(255, 255, 39, 111),
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
              "Explore Nail Services",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: getAllNail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final nail = snapshot.data![index];
                        bool isFavourite = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
                              shadowColor: Colors.grey.withOpacity(0.4),
                              child: Stack(
                                children: [
                                  // Card Content
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image with Favourite Icon
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          child: Image.network(
                                            nail['image']!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      // Details Section
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              nail['title']!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "Rs. ${nail['price']!}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Book Now Button
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 39, 111),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                            ),
                                            onPressed: () {
                                              openBookingPopup(
                                                  context,
                                                  nail["_id"],
                                                  nail['title'],
                                                  nail['price']!);
                                            },
                                            child: const Text(
                                              "Book Now",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Favourite Icon Positioned
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavourite = !isFavourite;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(isFavourite
                                                ? 'Added to Favourites'
                                                : 'Removed from Favourites'),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                            )
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          isFavourite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavourite
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
