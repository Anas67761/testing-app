// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:html';
import 'package:flutter_web_plugins/url_strategy.dart';

void configureApp() {
  setUrlStrategy(CustomUrlStrategy());
}

class CustomUrlStrategy extends UrlStrategy {
  @override
  String getPath() {
    // Returning the current path without any # symbol
    return window.location.pathname ?? ""; // No need to check for #
  }

  @override
  String prepareExternalUrl(String internalUrl) {
    // Clean URL without adding any # symbols
    return internalUrl;
  }

  @override
  void pushState(dynamic state, String title, String url) {
    // Push new state without # symbol in the URL
    window.history.pushState(state, title, url);
  }

  @override
  void replaceState(dynamic state, String title, String url) {
    // Replace the current state without # symbol
    window.history.replaceState(state, title, url);
  }

  @override
  VoidCallback addPopStateListener(void Function(Object?) fn) {
    void wrappedFn(Event event) {
      fn((event as PopStateEvent).state);
    }

    // Listen for the popstate event to handle browser navigation
    window.addEventListener('popstate', wrappedFn);
    return () => window.removeEventListener('popstate', wrappedFn);
  }

  @override
  Object? getState() {
    // Return the current state from the window's history
    return window.history.state;
  }

  @override
  Future<void> go(int count) async {
    // Navigate the history by 'count' steps
    window.history.go(count);
  }
}
