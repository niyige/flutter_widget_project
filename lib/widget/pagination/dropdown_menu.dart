import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef DropdownItemSelected<T> = void Function(T value, int index);

typedef DropdownCanceled = void Function();
enum DropdownLocation { top, bottom }

class DropdownMenu<T> extends StatefulWidget {
  final List<DropdownItem<T>> items;
  final DropdownItemSelected<DropdownItem<T>> onSelected;
  final DropdownCanceled onCanceled;
  final TextStyle textStyle;
  final double width;
  final DropdownLocation location;
  final int showCount;
  const DropdownMenu(
      {Key key,
      this.items,
      this.onSelected,
      this.onCanceled,
      this.textStyle,
      this.width = 0,
      this.location = DropdownLocation.bottom,
      this.showCount = 6})
      : super(key: key);
  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState<T> extends State<DropdownMenu<T>>
    with TickerProviderStateMixin {
  OverlayState _overlayState;
  List<OverlayEntry> _overlayEntryList = [];
  int selectedIndex = 0;
  double width;
  AnimationController controller;
  bool isShow = false;
  double itemHeight = 30;
  final LayerLink _layerLink = LayerLink();
  @override
  void initState() {
    super.initState();
    itemHeight = max(16 + widget.textStyle.fontSize, itemHeight);
    controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        lowerBound: 0,
        upperBound: 0.5,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward();
        showDropdown();
      },
      child: CompositedTransformTarget(
        link: this._layerLink,
        child: Container(
          padding: EdgeInsets.only(
            left: 14,
            right: 5,
          ),
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFDCDFE6)),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: max(widget.width,
                    _calculateMaxTextWidth(widget.textStyle, widget.items)),
                child: Text(
                  widget.items[selectedIndex].value.toString(),
                  maxLines: 1,
                  style: widget.textStyle,
                ),
              ),
              SizedBox(width: 8),
              RotationTransition(
                alignment: Alignment.center,
                turns: controller,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 17,
                  color: Color(0xFFC9CDD4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDropdown() {
    // if (_overlayEntryList.isNotEmpty) {
    //   _overlayState.insertAll(_overlayEntryList);
    //   return;
    // }
    _overlayState = Overlay.of(context, debugRequiredFor: widget);

    _overlayEntryList.add(_buildOutSideView());
    _overlayEntryList.add(_buildDropdownListView());
    _overlayState.insertAll(_overlayEntryList);
  }

  hideDropdown() {
    controller.reverse();
    for (OverlayEntry item in _overlayEntryList) {
      item.remove();
    }
    _overlayEntryList.clear();
  }

  _buildOutSideView() {
    return OverlayEntry(
        builder: (context) => Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (widget.onCanceled != null) widget.onCanceled();
                  hideDropdown();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ));
  }

  OverlayEntry _buildDropdownListView() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    double height = itemHeight * min(6, widget.items.length);
    return OverlayEntry(
      builder: (context) => Positioned(
        // left: offset.dx,
        // top: widget.location == DropdownLocation.bottom
        //     ? offset.dy + size.height + 5.0
        //     : offset.dy - height - 5.0,
        width: size.width,
        height: height,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(
              0.0,
              widget.location == DropdownLocation.bottom
                  ? size.height + 5.0
                  : -height - 5.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFDCDFE6)),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Material(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildItemView(widget.items[index], index);
                },
                itemCount: widget.items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemView(DropdownItem item, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onSelected != null) widget.onSelected(item, index);
        hideDropdown();
      },
      child: DropdownItemView(
        title: item.value.toString(),
        selected: index == selectedIndex,
        selectedColor: Color(0xFF4264F3),
        textStyle: widget.textStyle,
        height: itemHeight,
      ),
    );
  }

  /// 计算文字宽度
  double _calculateTextWidth(String text, TextStyle style) {
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      //locale: Localizations.localeOf(context),
      maxLines: 1,
      text: TextSpan(
        text: text,
        style: style,
      ),
    );
    textPainter.layout(minWidth: style.fontSize * text.length);
    return textPainter.width;
  }

  /// 计算文字宽度
  double _calculateMaxTextWidth(TextStyle style, List<DropdownItem<T>> items) {
    double width = 0;
    for (DropdownItem text in items) {
      width = max(_calculateTextWidth(text.value.toString(), style), width);
      print(width);
    }
    return width;
  }
}

class DropdownItemView extends StatefulWidget {
  final TextStyle textStyle;
  final Color selectedColor;
  final String title;
  final bool selected;
  final double height;
  const DropdownItemView(
      {Key key,
      this.textStyle,
      this.selectedColor,
      this.title,
      this.selected,
      this.height})
      : assert(textStyle != null && selectedColor != null),
        super(key: key);
  @override
  _DropdownItemViewState createState() => _DropdownItemViewState();
}

class _DropdownItemViewState extends State<DropdownItemView> {
  bool mouseEnter = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) => setState(() {
        mouseEnter = true;
      }),
      onExit: (PointerExitEvent event) => setState(() {
        mouseEnter = false;
      }),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: widget.height,
        color: mouseEnter ? Color(0xFFF5F7FA) : Colors.transparent,
        child: Text(widget.title,
            style: widget.selected
                ? widget.textStyle.copyWith(
                    color: widget.selectedColor, fontWeight: FontWeight.w500)
                : widget.textStyle),
      ),
    );
  }
}

class DropdownItem<T> {
  final T value;
  const DropdownItem({this.value});
}
