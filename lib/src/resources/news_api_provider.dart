import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart'
    show
        Client; // -> 'Client' - maintaining persistent connections across multiple requests to the same server. Then we can use MockClient in testing.

import '../models/item_model.dart';
import 'repository.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();
  final _urlTopIds = Uri.parse('$_root/topstories.json');

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(_urlTopIds);

    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(
      Uri.parse('$_root/item/$id.json'),
    );

    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
