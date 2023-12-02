import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({super.key, required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
      ),
      body: Text('$itemId'),
    );
  }
}
