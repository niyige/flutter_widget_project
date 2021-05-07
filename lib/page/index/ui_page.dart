import 'package:flutter/material.dart';
import 'package:flutter_widget_project/page/pagination_page.dart';
import 'package:flutter_widget_project/router/my_router.dart';

class UiPage extends StatefulWidget {
  @override
  createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: ListView(
        children: [
          _buildItemView("Pagination 分页", () {
            MyRouter.push(context, PaginationPage.routerName);
          }),
        ],
      ),
    );
  }

  _buildItemView(title, click) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: click,
      child: Container(
        height: 40,
        margin: EdgeInsets.only(left: 15, top: 15, right: 15),
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Image.asset("assets/common/ic_entry_img.png",
                width: 8, height: 14, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
