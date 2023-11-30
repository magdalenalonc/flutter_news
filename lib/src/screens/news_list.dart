import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            bloc.fetchItem(snapshot.data![index]);

            return NewsListTile(itemid: snapshot.data![index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // THIS IS BAD!!! NORMALLY DON'T DO THIS. TEMPORARY SOLUTION.
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top News',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
      ),
      body: buildList(bloc),
    );
  }
}
