import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/rank_page.dart';
import 'package:flutter_application_kobis_api/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 1;
  dynamic loadPage;
  var menus = [RankPage(), RankPage(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
      BottomNavigationBarItem(label: '박스오피스', icon: Icon(Icons.stars)),
      BottomNavigationBarItem(label: '영화 검색', icon: Icon(Icons.search))
    ];

    return Scaffold(
      body: loadPage,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _idx,
        onTap: (value) {
          setState(() {
            _idx = value;
            loadPage = menus[value];
          });
        },
      ),
    );
  }
}