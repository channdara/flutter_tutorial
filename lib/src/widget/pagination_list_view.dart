import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class _BaseListItemType {}

class _Loading extends _BaseListItemType {}

class PaginationScrollController extends ScrollController {
  final List<dynamic> _mainList = [];
  bool _hasNext = true;
  bool _callbackCalled = false;

  int get itemCount => _mainList.length;

  List<dynamic> get items => _mainList;

  @override
  void dispose() {
    _mainList.clear();
    _hasNext = true;
    _callbackCalled = false;
    super.dispose();
  }

  dynamic item(int index) => _mainList[index];

  void appendData({
    required List<dynamic> data,
    required bool hasNext,
  }) {
    _hasNext = hasNext;
    _callbackCalled = false;
    if (_mainList.isNotEmpty && _mainList.last is _Loading) {
      _mainList.removeLast();
    }
    _mainList.addAll(data);
    if (data.isNotEmpty && hasNext) {
      _mainList.add(_Loading());
    }
  }

  void setupScrollListener({
    required VoidCallback callback,
    double reserveSpace = 0.0,
  }) {
    addListener(() {
      final maxScrollExtent = position.maxScrollExtent;
      final calculate = maxScrollExtent * _clamp(0.0, 1.0, reserveSpace);
      final reserve = maxScrollExtent - calculate;
      final reachOffset = offset >= reserve;
      final inRange = !position.outOfRange;
      if (reachOffset && inRange && _hasNext && !_callbackCalled) {
        callback();
        _callbackCalled = true;
      }
    });
  }

  double _clamp(double minimum, double maximum, double value) =>
      max(minimum, min(value, maximum));
}

class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: const SizedBox(
        height: 32.0,
        width: 32.0,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class PaginationListView<T> extends StatelessWidget {
  const PaginationListView({
    super.key,
    required this.controller,
    required this.mainWidget,
    this.padding = EdgeInsets.zero,
    this.loadingWidget,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.itemExtent,
    this.itemExtentBuilder,
    this.prototypeItem,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  });

  final Widget Function(BuildContext context, int index, T item) mainWidget;
  final Widget? loadingWidget;
  final Widget? prototypeItem;
  final PaginationScrollController controller;
  final EdgeInsetsGeometry padding;
  final Axis scrollDirection;
  final bool reverse;
  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool? primary;
  final ScrollPhysics? physics;
  final double? itemExtent;
  final ItemExtentBuilder? itemExtentBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  Widget get _loadingWidget => loadingWidget ?? const _DefaultLoadingWidget();

  int get _itemCount => controller.itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: key,
      physics: physics,
      primary: primary,
      reverse: reverse,
      padding: padding,
      itemCount: _itemCount,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemExtent: itemExtent,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      prototypeItem: prototypeItem,
      scrollDirection: scrollDirection,
      dragStartBehavior: dragStartBehavior,
      itemExtentBuilder: itemExtentBuilder,
      semanticChildCount: semanticChildCount,
      addSemanticIndexes: addSemanticIndexes,
      addRepaintBoundaries: addRepaintBoundaries,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      findChildIndexCallback: findChildIndexCallback,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemBuilder: (context, index) {
        final item = controller.item(index);
        if (item is T) return mainWidget(context, index, item);
        if (item is _Loading) return _loadingWidget;
        return const SizedBox();
      },
    );
  }
}
