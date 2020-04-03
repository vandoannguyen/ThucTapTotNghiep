import 'dart:async';
import 'dart:collection';

import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/BlogEvent.dart';

class BasePresenter<V extends BaseView> {
  V baseView;
  HashMap<String, StreamController<BlocEvent>> streamController;

  BasePresenter() {
    streamController = new HashMap();
  }

  void addStreamController(k) {
    streamController.putIfAbsent(k, () => StreamController<BlocEvent>());
  }

  void intiView(V baseView) {
    this.baseView = baseView;
  }

  Sink getSink(k) {
    return streamController[k].sink;
  }

  Stream getStream(k) {
    return streamController[k].stream;
  }

  void onDispose() {
    streamController.forEach((f, v) {
      v.close();
    });
    streamController.clear();
  }
}
