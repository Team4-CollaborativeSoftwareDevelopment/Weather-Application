import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_forecast/screens/home_page.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _MyAppState();
}

class _MyAppState extends State<Index> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    MyHomePage(
      title: 'hey',
    ),
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
        body: _pages[_selectedIndex],
        bottomNavigationBar: SizedBox( child:BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Cities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Forecast',
            ),
            // Add your other items here
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),),
      ),
    );
  }
}
