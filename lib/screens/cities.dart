import 'package:flutter/material.dart';
import '../widgets/Wcard.dart';


class Cities extends StatelessWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
                width: 20,
              ),
              const Text(
                'Manage Cities',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: 240,
                    // Adjust the width as desired
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Location',
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          // Handle search query
                        },
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Add some space between the search bar and the icon
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        // Handle search action
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
               Wcard(
                date: '20/8/2023',
                city: 'cameroon',
                temperature: '21',
              ),
              Wcard(
                date: '20/8/2023',
                city: 'cameroon',
                temperature: '21',
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}