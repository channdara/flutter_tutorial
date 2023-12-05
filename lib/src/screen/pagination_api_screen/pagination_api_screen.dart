import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../widget/loading_widget.dart';
import 'news_event_response.dart';
import 'news_event_widget.dart';

class PaginationApiScreen extends StatefulWidget {
  const PaginationApiScreen({super.key});

  @override
  State<PaginationApiScreen> createState() => _PaginationApiScreenState();
}

class _PaginationApiScreenState extends State<PaginationApiScreen> {
  final ScrollController _controller = ScrollController();
  final List<dynamic> _mainList = [];
  final Dio _dio = Dio();

  int _page = 1;
  bool _hasMore = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchNewsListEvent();
    });
    _controller.addListener(_handleScrollController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchNewsListEvent() async {
    try {
      final rawResponse = await _dio.get(
        'https://sys.cus.edu.kh/api/v1/guest/news/list-of-event',
        queryParameters: {'page': _page},
      );
      final response = NewsEventResponse.from(rawResponse.data);
      _hasMore = response.data.isNotEmpty && response.data.length >= 10;
      _appendList(response.data);
      if (mounted) setState(() {});
    } catch (exception) {
      print('EXCEPTION: $exception');
    }
  }

  void _appendList(List<NewsEvent> append) {
    if (_mainList.isNotEmpty && _mainList.last is bool) {
      _mainList.removeLast();
    }
    _mainList.addAll(append);
    if (append.isNotEmpty && _hasMore) _mainList.add(true);
  }

  void _handleScrollController() {
    final offset = _controller.offset;
    final maxScrollExtent = _controller.position.maxScrollExtent;
    final outOfRange = _controller.position.outOfRange;
    if (offset >= maxScrollExtent && !outOfRange && _hasMore) {
      _page++;
      _fetchNewsListEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination API Screen')),
      body: ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.only(top: 16.0),
        itemCount: _mainList.length,
        itemBuilder: (context, index) {
          final item = _mainList[index];
          switch (item.runtimeType) {
            case NewsEvent:
              return NewsEventWidget(event: item as NewsEvent);
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
