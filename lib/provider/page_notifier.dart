import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setPage(int index) {
    state = index;
  }
}

final pageProvider = NotifierProvider<PageNotifier, int>(() => PageNotifier());
