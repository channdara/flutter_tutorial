import 'package:flutter/material.dart';

import '../../extension/contex_extension.dart';
import '../normal_pagination_screen/normal_pagination_screen.dart';
import '../pagination_api_screen/pagination_api_screen.dart';
import '../pagination_widget_screen/pagination_widget_screen.dart';
import '../pin_code_screen/pin_code_screen.dart';
import '../preload_pagination_screen/preload_pagination_screen.dart';
import 'main_screen_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Tutorial')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MainScreenWidget(
              onTap: () {
                context.push(const NormalPaginationScreen());
              },
              title: 'Pagination ListView',
              subtitle:
                  'This will show a demo of normal pagination list view which add more data when scroll reach bottom of the list',
            ),
            MainScreenWidget(
              onTap: () {
                context.push(const PreloadPaginationScreen());
              },
              title: 'Pre-Load Pagination ListView',
              subtitle:
                  'This will show a demo of a pre-load pagination list view which add more data before the scroll reached to the bottom of the list',
            ),
            MainScreenWidget(
              onTap: () {
                context.push(const PaginationApiScreen());
              },
              title: 'Pagination with API',
              subtitle:
                  'Demo of the implementation of pagination with real API request',
            ),
            MainScreenWidget(
              onTap: () {
                context.push(const PaginationWidgetScreen());
              },
              title: 'Custom ListView',
              subtitle:
                  'Custom Pagination ListView Widget for more easier to copy and use across multiple projects',
            ),
            MainScreenWidget(
              onTap: () {
                context.push(const PinCodeScreen());
              },
              title: 'Pin Code Screen',
              subtitle: 'The demo of input pin code dialog',
            ),
          ],
        ),
      ),
    );
  }
}
