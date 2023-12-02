import 'package:flutter/material.dart';

import 'screens/news_list.dart';
import '../constants.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        theme: kTheme,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) {
              return const NewsList();
            },
          );
        },
      ),
    );
  }
}
