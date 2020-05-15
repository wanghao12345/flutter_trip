import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

// 状态类
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState()
}

// 状态类里面的内部类，最前面用下划线表示
class _TabNavigatorState extends State<TabNavigator>{

  // 默认颜色
  final _defaultColor = Colors.grey;
  // 选中状态
  final _activeColor = Colors.blue;
  // 当前选中的tabBar
  int _currentIndex = 0;

  final PageController _controller = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor
            ),
            title: Text('首页', style: TextStyle(
              color: _currentIndex != 1 ? _defaultColor : _activeColor
            ),)
          )
        ],
      ),
    );
  }
}
