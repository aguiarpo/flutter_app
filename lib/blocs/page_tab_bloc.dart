import 'dart:async';

class NavigationDrawerBloc {
  final navigationController = StreamController();
  NavigationProvider navigationProvider = new NavigationProvider();

  Stream get getNavigation => navigationController.stream;

  int get getCurrentNavigation => navigationProvider.currentNavigation;

  void updateNavigation(int navigation) {
    navigationProvider.updateNavigation(navigation);
    navigationController.sink.add(navigationProvider
        .currentNavigation);
  }

  void dispose() {
    navigationController
        .close();
  }
}

class NavigationProvider {
  int currentNavigation = 0;

  void updateNavigation(int navigation){
    currentNavigation = navigation;
  }
}