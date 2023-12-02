import 'package:flutter/material.dart';

import 'foo.dart';
import 'foo_widget.dart';
import 'loading_widget.dart';

class NormalPaginationScreen extends StatefulWidget {
  const NormalPaginationScreen({super.key});

  @override
  State<NormalPaginationScreen> createState() => _NormalPaginationScreenState();
}

class _NormalPaginationScreenState extends State<NormalPaginationScreen> {
  final ScrollController _controller = ScrollController();
  final List<dynamic> _items = [];
  final bool _hasMore = true;

  @override
  void initState() {
    _generateFooItems();
    _controller.addListener(_handleScrollController);
    super.initState();
  }

  @override
  void dispose() {
    _items.clear();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generateFooItems() async {
    final data = Foo.generate();
    _appendList(data);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  void _appendList(List<Foo> append) {
    if (_items.isNotEmpty && _items.last is bool) {
      _items.removeLast();
    }
    _items.addAll(append);
    if (append.isNotEmpty && _hasMore) _items.add(true);
  }

  void _handleScrollController() {
    final offset = _controller.offset;
    final maxScrollExtent = _controller.position.maxScrollExtent;
    final outOfRange = _controller.position.outOfRange;
    if (offset >= maxScrollExtent && !outOfRange && _hasMore) {
      _generateFooItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination ListView')),
      body: ListView.builder(
        controller: _controller,
        padding: EdgeInsets.zero,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
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
