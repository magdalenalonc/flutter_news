import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesProvider({super.key, required super.child}) : bloc = StoriesBloc();

  final StoriesBloc bloc;

  @override
  bool updateShouldNotify(oldWidget) => true;

  // static method - do not have to create an instance of the provider to call it
  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>())!
        .bloc;
  }
}
