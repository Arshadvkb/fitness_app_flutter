import 'package:fitnessappnew/templates/expert/chat2.dart';
import 'package:fitnessappnew/templates/expert/side_menu.dart';
import 'package:fitnessappnew/templates/user/cb.dart';
import 'package:fitnessappnew/templates/user/user_menu.dart';
import 'package:fitnessappnew/templates/user/view_fee_details.dart';
import 'package:flutter/material.dart';

import '../login.dart';
import 'package:fitnessappnew/templates/user/view video.dart';
import 'package:fitnessappnew/templates/user/view_schedules.dart';
import 'package:fitnessappnew/templates/user/track_your_workout.dart';
import 'package:fitnessappnew/templates/user/view_health_tips.dart';
import 'package:fitnessappnew/templates/user/chat_with_expert.dart';
import 'package:fitnessappnew/templates/user/complaints.dart';
import '../user/view_profile.dart';

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    senddata();
  }

  String name = 'name';
  String pin = 'pin';
  String place = 'place';
  String phone = 'phone';
  String email = 'email';
  String image = 'image';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness App'),
        elevation: 0,
        automaticallyImplyLeading: true,
        // Remove the back button
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      drawer: Usermennu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(20),
              color: const Color.fromARGB(255, 13, 101, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        name, // Dynamic user name
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: image != 'image'
                        ? ClipOval(
                            child: Image.network(
                              image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.error,
                                  size: 40,
                                  color: Colors.red,
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.green,
                          ),
                  ),
                ],
              ),
            ),
            // Events
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'EVENTS',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Quick Actions
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quick Action',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            QuickActionCard(
                              icon: Icons.fitness_center,
                              title: 'view video',
                              onTap: () {
                                // Navigate to workout page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserViewCase()),
                                );
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.calendar_today,
                              title: 'Schedule',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TimeSchedulePage()),
                                );
                                // Navigate to schedule page
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.show_chart,
                              title: 'Track_Progress',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrackProgress()),
                                );
                                // Navigate to progress page
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.lightbulb,
                              title: 'view health tips',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const healthtips()),
                                );
                                // Navigate to health tips page
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.person,
                              title: 'chat with expert',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const chatwithexpert(),
                                  ),
                                );
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.money_outlined,
                              title: 'Fee Payment',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const view_fee_deatils(),
                                  ),
                                );
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.chat,
                              title: 'Chatbot',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const chatbot(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Workout Stats
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Today\'s Stats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: [
                              StatItem(
                                title: 'Calories',
                                value: '320',
                                unit: 'kcal',
                              ),
                              StatItem(
                                title: 'Time',
                                value: '45',
                                unit: 'min',
                              ),
                              StatItem(
                                title: 'Workouts',
                                value: '3',
                                unit: '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void senddata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse(url + "/user_home");
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          setState(() {
            email = jsonDecode(response.body)['email'].toString();
            name = jsonDecode(response.body)['name'].toString();
            phone = jsonDecode(response.body)['phone'].toString();

            place = jsonDecode(response.body)['place'].toString();
            image = sh.getString('imgurl2').toString() +
                jsonDecode(response.body)['image'];
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

// Reusable Quick Action Card Widget
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  QuickActionCard(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Stat Item Widget
class StatItem extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  StatItem({required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$title $unit',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
