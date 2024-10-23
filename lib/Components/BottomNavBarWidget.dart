import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final Function(String) onItemSelected; // Accepts route name

  const BottomNavBarWidget({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        width: 360,
        height: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.person, '/profile'),
            _buildNavItem(context, Icons.home_sharp, '/home'),
            _buildNavItem(context, Icons.settings_rounded, '/setting'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String routeName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 35),
          onPressed: () => onItemSelected(routeName), // Pass the route name
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 35,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white, // You can modify this to indicate the selected tab
            borderRadius: BorderRadius.circular(1.5),
          ),
        ),
      ],
    );
  }
}
