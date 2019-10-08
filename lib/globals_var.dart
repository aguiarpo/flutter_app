import 'dart:async';

class NavigationDrawerBloc {
  final navigationController = StreamController();
  NavigationProvider navigationProvider = new NavigationProvider();

  Stream get getNavigation => navigationController.stream;

  int get getCurrentNavigation => navigationProvider.currentNavigation;

  int get getCurrentNavigationPagePersons => navigationProvider.currentNavigationPagePersons;

  void updateNavigation(int navigation) {
    navigationProvider.updateNavigation(navigation);
    navigationController.sink.add(navigationProvider
        .currentNavigation);
  }

  void updateNavigationPagePersons(int navigation) {
    navigationProvider.updateNavigationPagePersons(navigation);
    navigationController.sink.add(navigationProvider
        .currentNavigationPagePersons);
  }

  void dispose() {
    navigationController
        .close();
  }
}

class NavigationProvider {
  int currentNavigation = 0;

  int currentNavigationPagePersons = 0;

  void updateNavigationPagePersons(int navigation){
    currentNavigationPagePersons = navigation;
  }

  void updateNavigation(int navigation){
    currentNavigation = navigation;
  }
}