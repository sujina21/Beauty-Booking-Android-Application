import 'package:flutter/material.dart';
import 'package:sprint_1/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to The Beauty Aesthetics",
      "description": "Your beauty journey starts here.",
      "image": "lib/assets/image/logo.png",
    },
    {
      "title": "Explore Our Services",
      "description": "Discover a wide range of beauty treatments.",
      "image": "lib/assets/image/services.jpg",
    },
    {
      "title": "Book Appointments Easily",
      "description": "Conveniently schedule your sessions.",
      "image": "lib/assets/image/booking.jpg",
    },
  ];

  void _onNextPressed() {
    if (_currentIndex == _onboardingData.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2F8),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        data["image"]!,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data["title"]!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B5E83),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data["description"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4B4B4B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ElevatedButton(
              onPressed: _onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE3A60),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                _currentIndex == _onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? const Color(0xFF8B5E83)
                      : const Color(0xFFD3D3D3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
