import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  // PublishSubject - exactly like a normal broadcast StreamController with one exception: this class is both a Stream and Sink.
  final _topIds = PublishSubject<List<int>>();
  // BehaviorSubject - a special StreamController that captures the latest item that has been added to the controller, and emits that as the first item to any new listener.
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  // getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

  // getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  // constructor function which will be invoked only one time -> so it's going to be reused for every single widget that tries to subscribe to the stream.
  // tranform - steam doesn't get modified. It returns a new stream.
  StoriesBloc() {
    // .pipe() - takes a source of events (stream here) and automatically forwards it on to some target destination. So everything that comes out of '_itemsFetcher' and its transformer automatically gets sent on to the '_itemsOutput'.
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }

    return null;
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    // from RxDart
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
