import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top News',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
      ),
      body: const Text('Show some news here!'),
    );
  }
}
