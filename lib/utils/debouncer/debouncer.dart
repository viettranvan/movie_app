import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer? _timer;
  Debouncer({
    this.duration = const Duration(milliseconds: 100),
  });
  call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}

class DebouncerScroll {
  final Duration duration;
  Timer? _timer;
  DebouncerScroll({
    this.duration = const Duration(milliseconds: 100),
  });
  bool call(VoidCallback callback,bool notification) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
    return notification;
  }

  dispose() {
    _timer?.cancel();
  }
}
