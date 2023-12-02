import 'package:flutter/material.dart';

import 'foo.dart';

class FooWidget extends StatelessWidget {
  const FooWidget({super.key, required this.foo});

  final Foo foo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle, size: 16.0),
      title: Text(
        foo.title,
        style: TextStyle(color: foo.id == 0 ? Colors.blue : Colors.black),
      ),
      subtitle: Text(
        foo.subtitle,
        style: TextStyle(color: foo.id == 0 ? Colors.blue : Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
