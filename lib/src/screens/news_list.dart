import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    
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
