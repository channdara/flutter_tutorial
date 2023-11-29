import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/extension/contex_extension.dart';
import 'package:flutter_tutorial/src/screen/normal_pagination_screen/normal_pagination_screen.dart';

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
            ListTile(
              onTap: () {
                context.push(const NormalPaginationScreen());
              },
              title: const Text('Pagination ListView'),
              subtitle: const Text(
                'This will show a demo of normal pagination list view which add more data when scroll reach bottom of the list',
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Pre-Load Pagination ListView'),
              subtitle: const Text(
                'This will show a demo of a pre-load pagination list view which add more data before the scroll reached to the bottom of the list',
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
