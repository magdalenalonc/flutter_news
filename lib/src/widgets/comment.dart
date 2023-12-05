import 'dart:async';

import 'package:flutter/material.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.itemId, required this.itemMap});

  final int itemId;
  final Map<int, Future<ItemModel?>> itemMap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Still loading comment');
        }

        return Text(snapshot.data!.text!);
      },
    );
  }
}
