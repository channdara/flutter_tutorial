import 'package:flutter/material.dart';

import '../../extension/contex_extension.dart';
import '../normal_pagination_screen/normal_pagination_screen.dart';
import 'list_tile_widget.dart';

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
            ListTileWidget(
              onTap: () {
                context.push(const NormalPaginationScreen());
              },
              title: 'Pagination ListView',
              subtitle:
                  'This will show a demo of normal pagination list view which add more data when scroll reach bottom of the list',
            ),
            ListTileWidget(
              onTap: () {},
              title: 'Pre-Load Pagination ListView',
              subtitle:
                  'This will show a demo of a pre-load pagination list view which add more data before the scroll reached to the bottom of the list',
            ),
          ],
        ),
      ),
    );
  }
}
