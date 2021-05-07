import 'package:flutter/material.dart';
import 'package:flutter_widget_project/widget/pagination/dropdown_menu.dart';
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
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyPagination(
                  totalCount: 101,
                  currentPage: 1,
                  pageSize: 2,
                  changePage: (int pageNum) {
                    //
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownMenu(
                  textStyle: TextStyle(color: Color(0xFF333333), fontSize: 15),
                  //width: 300,
                  location: DropdownLocation.top,
                  onSelected: (v, int index) {
                    print(v);
                    //
                  },
                  items: <DropdownItem<String>>[
                    DropdownItem(value: '10条/页'),
                    DropdownItem(value: '20条/页'),
                    DropdownItem(value: '30条/页'),
                    DropdownItem(value: '40条/页'),
                    DropdownItem(value: '50条/页'),
                    DropdownItem(value: '100条/页'),
                    // DropdownItem(value: '1000条/页'),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
