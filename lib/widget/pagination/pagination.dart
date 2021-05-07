import 'package:flutter/material.dart';

class MyPagination extends StatefulWidget {
  final int totalCount;

  final int currentPage;

  final int pageSize;

  final Function changePage;

  const MyPagination(
      {Key key,
      this.totalCount = 0,
      this.currentPage = 1,
      this.pageSize = 10,
      this.changePage})
      : super(key: key);

  @override
  createState() => _MyPaginationState();
}

class _MyPaginationState extends State<MyPagination> {
  // int pageSize = 1;

  int currentPage = 1;

  List pageList = [];

  bool isClick = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentPage = widget.currentPage ?? 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          ..._buildItemView(),
        ],
      ),
    );
  }

  _buildItemView() {
    int page;

    page = widget.totalCount ~/ widget.pageSize;

    print("${widget.totalCount % widget.pageSize}");

    //不能整除
    if (widget.totalCount % widget.pageSize > 0) {
      page += 1;
    }

    if (page <= 7) {
      pageList.clear();
      for (int i = 1; i <= page; i++) {
        pageList.add(i);
      }
    } else {
      //点击的时候改变
      if (isClick) {
        if (currentPage >= 5 && currentPage < page - 3) {
          pageList.clear();
          pageList.add(1);
          pageList.add(currentPage - 3);
          pageList.add(currentPage - 2);
          pageList.add(currentPage - 1);
          if (currentPage != page) pageList.add(currentPage);
          if (currentPage + 1 < page) {
            pageList.add(currentPage + 1);
          }
          if (currentPage + 2 < page) pageList.add(currentPage + 2);
          if (currentPage + 3 < page) pageList.add(currentPage + 3);

          pageList.add(page);
        } else if (currentPage < 5) {
          pageList.clear();
          for (int i = 1; i <= 7; i++) {
            pageList.add(i);
          }
          // pageList.add(page - 1);
          pageList.add(page);
        } else if (currentPage >= page - 3) {
          List<int> list = [];
          for (int i = page; i > 0; i--) {
            if (list.length >= 7) {
              break;
            }
            list.add(i);
          }
          list = list.reversed.toList();

          list.insert(0, 1);

          pageList = list;
        }
      } else {
        pageList.clear();
        for (int i = 1; i <= 7; i++) {
          pageList.add(i);
        }
        if (pageList.length > 7) {
          pageList.add(page - 1);
        }
        pageList.add(page);
      }
    }

    return pageList
        .map((e) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print("index = ${pageList.indexOf(e)}");
                setState(() {
                  if (pageList.indexOf(e) == 1 && e > 5) {
                    currentPage = e - 2;
                  } else if (pageList.indexOf(e) + 1 == pageList.length - 1 &&
                      currentPage < 5 &&
                      currentPage + 5 <= page) {
                    currentPage = currentPage + 5;
                  } else if (pageList.indexOf(e) + 1 == pageList.length - 1 &&
                      page - e >= 2) {
                    currentPage = e + 2;
                  } else if (pageList.indexOf(e) + 1 == pageList.length - 1 &&
                      page - e == 1 &&
                      page - currentPage == 4) {
                    //一个特定的情况 ，特殊处理
                    currentPage = page;
                  } else {
                    currentPage = e;
                  }

                  isClick = true;
                });
                //页数改变需要刷新数据
                if (null != widget.changePage) widget.changePage(e);
              },
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                child: Text(
                  (page > 7 &&
                              (pageList.indexOf(e) + 1) ==
                                  pageList.length - 1 &&
                              page - currentPage > 3) ||
                          (page > 7 &&
                              (pageList.indexOf(e) + 1) == 2 &&
                              currentPage > 4)
                      ? "..."
                      : "$e",
                  style: TextStyle(
                      fontSize: 13,
                      color: currentPage == e ? Colors.green : Colors.black),
                ),
              ),
            ))
        .toList();
  }
}
