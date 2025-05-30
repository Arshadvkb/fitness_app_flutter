import 'package:fitnessappnew/templates/expert/expert_home.dart';
import 'package:fitnessappnew/templates/login.dart';
import 'package:fitnessappnew/templates/user/user_home.dart';
import 'package:fitnessappnew/templates/user/view_profile.dart';
import 'package:flutter/material.dart';

import 'complaints.dart';

class Usermennu extends StatelessWidget {
  const Usermennu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.green,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'USER MENU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home, color: Colors.green),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.warning, color: Colors.green),
                  title: const Text(
                    'Complaints',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const complaints()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person_2, color: Colors.green),
                  title: const Text(
                    'View Profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              user_profile(title: 'View Profile')),
                    );
                  },
                ),
                // Add more navigation items here
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
