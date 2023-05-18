import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_forecast/screens/cities.dart';
import 'package:weather_forecast/screens/home_page.dart';
import 'package:weather_forecast/widgets/Wcard.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _MyAppState();
}

class _MyAppState extends State<Index> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const MyHomePage(title: 'hey'),
    const Cities(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: GNav(
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.lightBlueAccent,
            gap: 8,
            padding: EdgeInsets.all(14),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ('Home'),
              ),
              GButton(
                icon: Icons.location_city,
                text: ('Cities'),
              ),
              GButton(
                icon: Icons.calendar_month,
                text: ('Forecast'),
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Screen'),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Screen'),
    );
  }
}
