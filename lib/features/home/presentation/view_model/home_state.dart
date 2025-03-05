import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/booking_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/nails_screen.dart';
import 'package:beauty_booking_app/features/home/presentation/view/bottom_view/profile_screen.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Updated initial state with correct views
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const DashboardScreen(), 
        const BookingScreen(),
        const AboutUsScreen(),
        const ProfileScreen(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
