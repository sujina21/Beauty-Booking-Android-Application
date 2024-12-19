import 'package:flutter/material.dart';
import 'package:sprint_1/view/makeup_screen.dart';
import 'package:sprint_1/view/nails_screen.dart';
import 'package:sprint_1/view/discover_screen.dart'; 
import 'package:sprint_1/view/cart_screen.dart'; 
import 'package:sprint_1/view/profile_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          _buildSearchBar(),
          const SizedBox(height: 30),
          _buildServicesSection(context),
          const SizedBox(height: 30),
          _buildProductsSection(),
          const SizedBox(height: 30),
          _buildResponsiveNavBar(context),
        ],
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
           BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search for service",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // Services Section
  Widget _buildServicesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Services", "view all services"),
          const SizedBox(height: 10),
          _buildImageRow([
            _buildServiceCard(context, "lib/assets/image/makeup.jpg", "Makeup",
                const MakeupScreen()),
            _buildServiceCard(context, "lib/assets/image/nails.jpg", "Nails",
                const NailsScreen()),
          ]),
        ],
      ),
    );
  }

  // Products Section
  Widget _buildProductsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Products", "view all Products"),
          const SizedBox(height: 10),
          _buildImageRow([
            _buildProductCard("lib/assets/image/product1.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product2.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product3.jpg", "Rs. 2000/-"),
          ]),
          _buildImageRow([
            _buildProductCard("lib/assets/image/product4.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product5.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product6.jpg", "Rs. 2000/-"),
          ]),
          _buildImageRow([
            _buildProductCard("lib/assets/image/product7.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product8.jpg", "Rs. 2000/-"),
            _buildProductCard("lib/assets/image/product9.jpg", "Rs. 2000/-"),
          ]),
        ],
      ),
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title, String linkText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          linkText,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              decoration: TextDecoration.underline),
        ),
      ],
    );
  }

  // Helper method to build image row
  Widget _buildImageRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }

  // Service Card with Navigation
  Widget _buildServiceCard(
      BuildContext context, String imagePath, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Product Card
  Widget _buildProductCard(String imagePath, String price) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          price,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  // Responsive Bottom Navigation Bar
  Widget _buildResponsiveNavBar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home, "Home", context, isActive: true),
              _buildBottomNavItem(Icons.explore, "Discover", context),
              _buildBottomNavItem(Icons.shopping_cart, "Cart", context),
              _buildBottomNavItem(Icons.account_circle, "Profile", context),
            ],
          ),
        );
      },
    );
  }

  // Bottom Navigation Bar Item with Navigation
  Widget _buildBottomNavItem(IconData icon, String label, BuildContext context,
      {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective pages
        if (label == "Discover") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DiscoverScreen()));
        } else if (label == "Cart") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (label == "Profile") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.black : Colors.grey),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
                fontSize: 12, color: isActive ? Colors.black : Colors.grey),
          ),
        ],
      ),
    );
  }
}
