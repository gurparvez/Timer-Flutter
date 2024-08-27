import 'dart:async';
import 'package:flutter/material.dart';

class DigitalClock2 extends StatefulWidget {
  const DigitalClock2({super.key});

  @override
  State<DigitalClock2> createState() => _DigitalClock2State();
}

class _DigitalClock2State extends State<DigitalClock2> {
  String _timeString = "";

  String _formatDateTime(DateTime dateTime) {
    String hour = "${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}";
    String amPm = dateTime.hour >= 12 ? "PM" : "AM";
    return "${hour.padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} $amPm";
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          _timeString,
          style: TextStyle(
            fontSize: screenWidth * 0.2,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}