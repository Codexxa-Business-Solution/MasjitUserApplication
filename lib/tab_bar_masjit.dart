import 'package:flutter/material.dart';

class TabBarExample extends StatefulWidget {
  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  bool showTabs = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text(
            '_appBarText',
            style: TextStyle(
              color: Color(0xFF1C2447),
              fontFamily: 'Muli',
              fontSize: 16.0,
            ),
          ),
          bottom: showTabs
              ? TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Choice1',
                icon: Icon(Icons.add_circle_outline),
              ),
              Tab(
                text: 'Choice1',
                icon: Icon(Icons.add_circle),
              ),
            ],
            labelColor: Color(0xFF1C2447),
          )
              : null,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: ("Aaysha")),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: ("Aaysha2")),
          ],
          onTap: (index) {
            if (index == 1) {
              setState(() => showTabs = true);
            } else {
              setState(() => showTabs = false);
            }
            setState(() => selectedIndex = index);
          },
        ),
      ),
    );
  }
}