import 'package:flutter/material.dart';
import 'package:flutter_widget_project/widget/pagination/pagination.dart';

/**
 * 分页
 */
class PaginationPage extends StatefulWidget {
  static const routerName = 'oyy://pagination_Page';
  static const routerTitle = 'pagination 页面';

  @override
  createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Pagination 分页"),
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: 100,
              right: 30,
              // width: MediaQuery.of(context).size.width,
              child: MyPagination(
                totalCount: 101,
                currentPage: 1,
                changePage: (int pageNum) {
                  //
                },
              )),
        ],
      ),
    );
  }
}
