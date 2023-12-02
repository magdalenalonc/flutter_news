import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  const Refresh({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
      child: child,
    );
  }
}
