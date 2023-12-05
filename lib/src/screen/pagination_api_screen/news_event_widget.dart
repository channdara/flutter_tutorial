import 'package:flutter/material.dart';

import 'news_event_response.dart';

class NewsEventWidget extends StatelessWidget {
  const NewsEventWidget({super.key, required this.event});

  final NewsEvent event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0).copyWith(top: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                event.image,
                height: 64.0,
                width: 64.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Text(event.date),
                  const SizedBox(height: 12.0),
                  Text(event.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
