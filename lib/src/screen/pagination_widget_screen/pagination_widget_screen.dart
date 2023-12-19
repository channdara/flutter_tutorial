import 'package:flutter/material.dart';

import '../../model/foo.dart';
import '../../widget/foo_widget.dart';
import '../../widget/pagination_list_view.dart';

class PaginationWidgetScreen extends StatefulWidget {
  const PaginationWidgetScreen({super.key});

  @override
  State<PaginationWidgetScreen> createState() => _PaginationWidgetScreenState();
}

class _PaginationWidgetScreenState extends State<PaginationWidgetScreen> {
  final PaginationScrollController _controller = PaginationScrollController();
  int _page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _generateFooItems(false);
    });
    _controller.setupScrollListener(
      reserveSpace: 0.5,
      callback: () {
        _generateFooItems();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _page = 1;
    super.dispose();
  }

  Future<void> _generateFooItems([bool delay = true]) async {
    final data = Foo.generate();
    if (delay) await Future.delayed(const Duration(seconds: 2));
    _controller.appendData(data: data, hasNext: ++_page <= 5);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination Widget Screen')),
      body: PaginationListView<Foo>(
        controller: _controller,
        mainWidget: (context, index, item) {
          return FooWidget(foo: item);
        },
      ),
    );
  }
}
