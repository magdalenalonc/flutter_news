import 'dart:convert';
import 'package:http/http.dart'
    show
        Client; // -> 'Client' - maintaining persistent connections across multiple requests to the same server.

import '../models/item_model.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  final Client client = Client();

  fetchTopIds() async {
    final response = await client.get(
      Uri.https('$_root/topstories.json'),
    );

    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get(
      Uri.https('$_root/item/$id.json'),
    );

    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}