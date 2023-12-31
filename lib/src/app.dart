import 'package:flutter/material.dart';

import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import '../constants.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();

          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          // Here is a great location to do some initialization or data fetching for NewsDetail.
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          theme: kTheme,
          onGenerateRoute: routes,
        ),
      ),
    );
  }
}
