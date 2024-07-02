import 'dart:async';

class DispatchScreenStreamController {
  final StreamController<bool> controller;

  DispatchScreenStreamController({required this.controller}) {
    controller.sink.add(false);
  }

  void add(bool event) {
    controller.sink.add(event);
  }

  void close() {
    controller.close();
  }

  Stream<bool> get stream => controller.stream;
}
