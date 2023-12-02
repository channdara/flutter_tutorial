import 'package:flutter/material.dart';

import '../../model/foo.dart';
import '../../widget/foo_widget.dart';
import '../../widget/loading_widget.dart';

class PreloadPaginationScreen extends StatefulWidget {
  const PreloadPaginationScreen({super.key});

  @override
  State<PreloadPaginationScreen> createState() =>
      _PreloadPaginationScreenState();
}

class _PreloadPaginationScreenState extends State<PreloadPaginationScreen> {
  final ScrollController _controller = ScrollController();
  final List<dynamic> _mainList = [];

  bool _hasMore = true;
  bool _requesting = false;
  double? _reserveHigh;

  @override
  void initState() {
    /// addPostFrameCallback is to let the UI build complete
    /// before requesting data from API.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _generateFooItems(false);
    });

    /// add listener to scroll controller
    _controller.addListener(_handleScrollController);
    super.initState();
  }

  @override
  void dispose() {
    _mainList.clear();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generateFooItems([bool delay = true]) async {
    /// cause checking scroll not reach bottom, this function will call
    /// multiple time, so add a variable to check and prevent it load
    /// multiple time
    if (_requesting) return;

    /// this will replace with getting data from API
    final data = Foo.generate();

    /// just for testing, remove when use with requesting API
    if (delay) await Future.delayed(const Duration(seconds: 1));

    /// after received data from API, append the list
    _appendList(data);

    /// setting this to false when API request success
    _requesting = false;

    /// this will replace with state management to tell the list widget
    /// to rebuild the UI with list items
    if (mounted) setState(() {});
  }

  void _appendList(List<Foo> append) {
    /// check remove last item to hide the loading widget
    if (_mainList.isNotEmpty && _mainList.last is bool) {
      _mainList.removeLast();
    }

    /// add all new items to the main list
    _mainList.addAll(append);

    /// check if condition meet, add a boolean to show the
    /// loading widget in listview
    if (append.isNotEmpty && _hasMore) _mainList.add(true);
  }

  /// normal check for listview when scroll almost reach bottom of the list
  /// and _hasMore is true, request next page data from API. dont forget
  /// to set _requesting to true after call getting data function
  void _handleScrollController() {
    final offset = _controller.offset;
    final maxScrollExtent = _controller.position.maxScrollExtent;
    _reserveHigh ??= maxScrollExtent / 2;
    final preLoadOffset = maxScrollExtent - _reserveHigh!;
    final outOfRange = _controller.position.outOfRange;
    if (offset >= preLoadOffset && !outOfRange && _hasMore) {
      _generateFooItems();
      _requesting = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Load Pagination ListView')),
      body: ListView.builder(
        controller: _controller,
        padding: EdgeInsets.zero,
        itemCount: _mainList.length,
        itemBuilder: (context, index) {
          /// check item runtimeType from main list cause it is dynamic
          /// if the item type is Foo object, build FooWidget
          /// if the item is boolean, build LoadingWidget
          /// other item type will not show anything
          final item = _mainList[index];
          switch (item.runtimeType) {
            case Foo:
              return FooWidget(foo: item as Foo);
            case bool:
              return const LoadingWidget();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
