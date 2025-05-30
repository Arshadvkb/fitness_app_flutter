import 'dart:convert';
// import 'package:fitnessappnew/templates/user/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'user_menu.dart';

class TimeSchedulePage extends StatefulWidget {
  const TimeSchedulePage({Key? key}) : super(key: key);

  @override
  _TimeSchedulePageState createState() => _TimeSchedulePageState();
}

class _TimeSchedulePageState extends State<TimeSchedulePage> {
  List<ScheduleItem> _scheduleItems = [];

  @override
  void initState() {
    super.initState();
    fetchTimeScheduleData();
  }

  Future<void> fetchTimeScheduleData() async {
    final sh = await SharedPreferences.getInstance();
    String? url = sh.getString("url");
    String? lid = sh.getString("lid");

    if (url == null || lid == null) {
      throw Exception('URL or LID is null');
    }

    final response = await http.post(
      Uri.parse(url + '/user_view_time'),
      headers: {
        'Content-Type': 'application/json', // Ensure you're sending JSON
      },
      body: json.encode({'lid': lid}), // Send 'lid' in the body
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        _scheduleItems = List<ScheduleItem>.from(
          data['data'].map((item) => ScheduleItem.fromJson(item)),
        );
      });
    } else {
      throw Exception('Failed to load time schedule');
    }
  }

  Future<String?> getUsername() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? lid = sh.getString('lid');
    String? url = sh.getString('url');
    print(url);
    print('iuuuuuuuurl');

    try {
      final response = await http.get(Uri.parse(url! + 'get-username/$lid/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['username'];
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Schedule'),
        iconTheme:
            IconThemeData(color: Colors.green), // Change icon color to green
      ),
      drawer: Usermennu(),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          final schedule = _scheduleItems[index];
          return Column(
            children: [
              ScheduleCard(
                date: schedule.fromTime,
                time: schedule.toTime,
                trainer: schedule.trainer,
              ),
              SizedBox(height: 16), // Add gap between containers
            ],
          );
        },
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  final String trainer;

  const ScheduleCard({
    required this.date,
    required this.time,
    required this.trainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make container full width
      padding: EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: $date',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Time: $time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Trainer: $trainer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

// Model for ScheduleItem
class ScheduleItem {
  final String trainer;
  final String fromTime;
  final String toTime;

  ScheduleItem(
      {required this.trainer, required this.fromTime, required this.toTime});

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      trainer: json['TRAINER'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
    );
  }
}
