import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasTextStreamControllerProvider = Provider(
  (ref) => StreamController<bool>(),
);

final hasTextStreamProvider = StreamProvider.family<bool,StreamController<bool>>(
  (ref,controller) {
    // final controller = ref.watch(hasTextStreamControllerProvider);
    return controller.stream;
  },
);
