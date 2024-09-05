// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:html';
import 'package:flutter_web_plugins/url_strategy.dart';

void configureApp() {
  setUrlStrategy(CustomUrlStrategy());
}

class CustomUrlStrategy extends UrlStrategy {
  @override
  String getPath() {
    // Custom logic to get the current path
    return window.location.pathname ?? '';
  }

  @override
  String prepareExternalUrl(String internalUrl) {
    // Custom logic for preparing the external URL
    return internalUrl;
  }

  @override
  void pushState(dynamic state, String title, String url) {
    // Custom logic for pushState
    window.history.pushState(state, title, url);
  }

  @override
  void replaceState(dynamic state, String title, String url) {
    // Custom logic for replaceState
    window.history.replaceState(state, title, url);
  }

  @override
  VoidCallback addPopStateListener(void Function(Object?) fn) {
    void wrappedFn(Event event) {
      fn((event as PopStateEvent).state);
    }

    window.addEventListener('popstate', wrappedFn);
    return () => window.removeEventListener('popstate', wrappedFn);
  }

  @override
  Object? getState() {
    // Implement getState
    return window.history.state;
  }

  @override
  Future<void> go(int count) async {
    // Implement go
    window.history.go(count);
  }
}
