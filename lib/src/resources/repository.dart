import 'dart:async';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider, // we can't do multiple instances of NewsDbProvider() because SQL doens't like this approach to open the same database multiple times. So in NewsDbProvider class we created global 'newsDbProvider' variable for ONLY ONE AND THE SAME database.
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  // Todo - iterate over sources when dbprovider get fetchTopIds implemented
  Future<List<int>>? fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    var source;

    for (var source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (item != null && cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
