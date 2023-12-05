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
  final PaginationScrollController controller = PaginationScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _generateFooItems(false);
    });
    controller.setupScrollListener(() {
      _generateFooItems();
    }, reserveSpace: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    page = 1;
    super.dispose();
  }

  Future<void> _generateFooItems([bool delay = true]) async {
    final data = Foo.generate();
    if (delay) await Future.delayed(const Duration(seconds: 2));
    controller.appendData(data, hasNext: ++page <= 5);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination Widget Screen')),
      body: PaginationListView<Foo>(
        controller: controller,
        mainWidget: (context, item) {
          return FooWidget(foo: item);
        },
        loadingWidget: (context) {
          return Container(height: 32.0, width: 32.0, color: Colors.red);
        },
      ),
    );
  }
}
