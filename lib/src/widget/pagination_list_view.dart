import 'dart:math';

import 'package:flutter/material.dart';

class PaginationScrollController extends ScrollController {
  final List<dynamic> mainList = [];
  bool _hasNext = true;
  bool _callbackCalled = false;

  @override
  void dispose() {
    mainList.clear();
    _hasNext = true;
    super.dispose();
  }

  void appendData(List<dynamic> data, {bool hasNext = true}) {
    _hasNext = hasNext;
    _callbackCalled = false;
    if (mainList.isNotEmpty && mainList.last == _PaginationItemType.loading) {
      mainList.removeLast();
    }
    mainList.addAll(data);
    if (data.isNotEmpty && hasNext) {
      mainList.add(_PaginationItemType.loading);
    }
  }

  void setupScrollListener(
    VoidCallback callback, {
    double reserveSpace = 0.0,
  }) {
    addListener(() {
      final maxScrollExtent = position.maxScrollExtent;
      final calculate = maxScrollExtent * _clamp(0.0, 1.0, reserveSpace);
      final reserve = maxScrollExtent - calculate;
      final reach = offset >= reserve;
      final inRange = !position.outOfRange;
      if (reach && inRange && _hasNext && !_callbackCalled) {
        callback();
        _callbackCalled = true;
      }
    });
  }

  double _clamp(double minimum, double maximum, double value) =>
      max(minimum, min(value, maximum));
}

class PaginationListView<T> extends StatefulWidget {
  const PaginationListView({
    super.key,
    required this.controller,
    required this.mainWidget,
    this.padding = EdgeInsets.zero,
    this.loadingWidget,
  });

  final Widget Function(BuildContext context, T item) mainWidget;
  final WidgetBuilder? loadingWidget;
  final PaginationScrollController controller;
  final EdgeInsetsGeometry padding;

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  Widget _loadingWidget = const _DefaultLoadingWidget();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.loadingWidget == null) return;
      _loadingWidget = widget.loadingWidget!.call(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      controller: widget.controller,
      itemCount: widget.controller.mainList.length,
      itemBuilder: (context, index) {
        final item = widget.controller.mainList[index];
        if (item is T) {
          return widget.mainWidget(context, item);
        }
        if (item == _PaginationItemType.loading) {
          return _loadingWidget;
        }
        return const SizedBox();
      },
    );
  }
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

enum _PaginationItemType { loading }
