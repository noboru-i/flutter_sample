import 'package:flutter_sample/screens/bottom_tab/bottom_tab_state.dart';
import 'package:state_notifier/state_notifier.dart';

class BottomTabStateNotifier extends StateNotifier<BottomTabState> {
  BottomTabStateNotifier() : super(const BottomTabState());

  Map<TabItem, RefreshListener> listeners = {};

  void addRefreshListener(TabItem item, RefreshListener listener) {
    listeners[item] = listener;
  }

  void removeRefreshListener(TabItem item) {
    listeners.remove(item);
  }

  void notifyRefresh(TabItem item) {
    print('refresh type $item');
    listeners[item]?.call();
  }
}

enum TabItem {
  home,
  account,
}

typedef RefreshListener = void Function();
