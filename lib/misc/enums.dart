enum LocaleType { english }
enum ItemState { Incomplete, Complete }
enum AppRoute { root, addTodoItem }

extension AppRouteToPath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.root:
        return '/';
      case AppRoute.addTodoItem:
        return '/addTodoItem';
    }
  }
}
