import 'dart:async';

import 'package:flutter/material.dart';

import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  const Comment(
      {super.key,
      required this.itemId,
      required this.itemMap,
      required this.depth});

  final int itemId;
  final Map<int, Future<ItemModel?>> itemMap;
  final int depth;

  Widget buildText(ItemModel item) {
    final text = item.text!
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x3A;', ':')
        .replaceAll('&#x2F;', '/')
        .replaceAll('&#x3F;', '?');

    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        final item = snapshot.data!;
        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == '' ? const Text('Deleted') : Text(item.by!),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          const Divider(),
        ];

        item.kids!.forEach(
          (kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          },
        );

        return Column(
          children: children,
        );
      },
    );
  }
}
