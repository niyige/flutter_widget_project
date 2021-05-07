import 'package:flutter/material.dart';
import 'package:flutter_widget_project/home_tab_icon_icons.dart';
import 'package:flutter_widget_project/page/index/index.dart';
import 'package:flutter_widget_project/page/index/mine.dart';
import 'package:flutter_widget_project/page/index/ui_page.dart';

/**
 * 
 * home page
 */
class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: TabBar(
                indicatorWeight: 1,
                tabs: [
                  Tab(
                    icon: Icon(HomeTabIcon.desktop_mac, size: 20),
                    text: '首页',
                  ),
                  Tab(
                    icon: Icon(HomeTabIcon.shopping_basket, size: 20),
                    text: 'ui库',
                  ),
                  Tab(
                    icon: Icon(
                      HomeTabIcon.event_seat,
                      size: 20,
                    ),
                    text: '我的',
                  ),
                ],
                unselectedLabelColor: Color(0xFFAEAEAE),
                labelColor: Colors.green,
                indicatorColor: Colors.transparent,
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            IndexPage(),
            UiPage(),
            MinePage(),
          ],
        ),
      ),
    );
  }
}
