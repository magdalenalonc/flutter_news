import 'package:flutter/material.dart';

import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  CommentsProvider({super.key, required super.child}) : bloc = CommentsBloc();

  final CommentsBloc bloc;

  @override
  bool updateShouldNotify(oldWidget) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>())!
        .bloc;
  }
}
