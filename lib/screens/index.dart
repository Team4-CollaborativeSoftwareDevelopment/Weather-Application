import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_forecast/screens/cities.dart';
import 'package:weather_forecast/screens/home_page.dart';
import 'package:weather_forecast/screens/weather_forecast_screen.dart';
import 'package:weather_forecast/widgets/Wcard.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _MyAppState();
}

class _MyAppState extends State<Index> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  static final List<Widget> _pages = <Widget>[
    const MyHomePage(title: 'hey'),
    const Cities(),
    WeatherForecastScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 1.0,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            tabBackgroundColor: Colors.purple.shade300,
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
            onTabChange: (index) {
              _animationController.forward(from: 0.0);
              _onItemTapped(index);
            },
          ),
        ),
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            if (_animationController.value == 1.0) {
              return IndexedStack(
                index: _selectedIndex,
                children: _pages,
              );
            } else {
              return FadeTransition(
                opacity: _animation,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              );
            }
          },
        ),
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
