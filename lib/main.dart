import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DigitalClock1.dart';
import 'DigitalClock2.dart';
import 'DigitalClock3.dart';
import 'DigitalClock4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Screen Clocks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageViewWithDots(),
    );
  }
}

class PageViewWithDots extends StatefulWidget {
  const PageViewWithDots({super.key});

  @override
  _PageViewWithDotsState createState() => _PageViewWithDotsState();
}

class _PageViewWithDotsState extends State<PageViewWithDots> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 4;

  @override
  void initState() {
    super.initState();
    _loadCurrentPage();
    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      setState(() {
        _currentPage = newPage;
        _saveCurrentPage(_currentPage);
      });
    });
  }

  Future<void> _loadCurrentPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPage = prefs.getInt('currentPage') ?? 0;
      _pageController.jumpTo(_currentPage.toDouble());
    });
  }

  Future<void> _saveCurrentPage(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentPage', page);
    print(prefs.getInt('currentPage'));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: const [
              DigitalClock1(),
              DigitalClock2(),
              DigitalClock3(),
              DigitalClock4(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_numPages, (index) {
            return AnimatedContainer(
              duration: Duration(microseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              height: 8,
              width: _currentPage == index ? 20 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.white : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
