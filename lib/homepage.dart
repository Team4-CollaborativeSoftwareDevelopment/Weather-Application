import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: GNav(
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.lightBlueAccent,
          gap: 8,
          padding: EdgeInsets.all(14),
          tabs: [
            GButton(
              icon: Icons.home,
              text: ('Home'),
            ),
            GButton(
              icon: Icons.search,
              text: ('Search'),
            ),
            GButton(
              icon: Icons.settings,
              text: ('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
