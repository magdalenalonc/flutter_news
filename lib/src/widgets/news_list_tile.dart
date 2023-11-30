import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.itemid});

  final int itemid;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Stream still loading');
        }

        return FutureBuilder(
          future: snapshot.data![itemid],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Still loading item $itemid');
            }

            return Text(itemSnapshot.data!.title!);
          },
        );
      },
    );
  }
}
