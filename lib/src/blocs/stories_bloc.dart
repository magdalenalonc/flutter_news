import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  // PublishSubject - exactly like a normal broadcast StreamController with one exception: this class is both a Stream and Sink.
  final _topIds = PublishSubject<List<int>>();
  // BehaviorSubject - a special StreamController that captures the latest item that has been added to the controller, and emits that as the first item to any new listener.
  final _items = BehaviorSubject<int>();

  late Stream<Map<int, Future<ItemModel?>>> items;


  // getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;

  // getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  // constructor function which will be invoked only one time -> so it's going to be reused for every single widget that tries to subscribe to the stream.
  // tranform - steam doesn't get modified. It returns a new stream.
  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }

    return null;
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
