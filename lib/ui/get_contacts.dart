// lib/ui/get_contacts.dart
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _selectedIndex = 0; // Track selected index for navigation

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( // Wrap with LayoutBuilder for responsive adjustments
      builder: (context, constraints) {
        // Calculate responsive padding based on screen width
        final double responsivePadding = constraints.maxWidth < 600 ? 15.0 : 30.0;

        return Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsivePadding, // Apply responsive padding
                vertical: 20.0,
              ),
              child: GNav(
                rippleColor: Colors.grey,
                hoverColor: Colors.grey,
                haptic: true,
                // tabBorderRadius: 15,
                curve: Curves.linear,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8,
                onTabChange: (index) {
                  setState(() => _selectedIndex = index);
                },
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Favorites',
                  ),
                  GButton(
                    icon: Icons.account_circle_outlined,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          body: IndexedStack( // Use IndexedStack for content based on selected index
            index: _selectedIndex,
            children: const [
              // Replace these with your content widgets for each tab
              Center(child: Text('Home Content')),
              Center(child: Text('Search Content')),
              Center(child: Text('Favorites Content')),
              Center(child: Text('Profile Content')),
            ],
          ),
        );
      },
    );
  }
}
