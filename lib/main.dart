import 'package:flutter/material.dart';
import 'package:flutter_widget_project/page/home.dart';
import 'package:flutter_widget_project/page/pagination_page.dart';
import 'package:flutter_widget_project/router/my_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    MyRouter.setFlutterRouter((settings) => {
          HOME_PAGE: HomePage(),
          PaginationPage.routerName: PaginationPage(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: MyRouter.init(),
      color: Colors.white,
      home: HomePage(),
    );
  }
}
