import 'package:mobx/mobx.dart';

part 'custom_drawer_store.g.dart';

// This is the class used by rest of your codebase
class CustomDrawerStore = CustomDrawerStoreBase with _$CustomDrawerStore;

// The store-class
abstract class CustomDrawerStoreBase with Store {
  @observable
  int selectedMenu = 1;

  @action
  void setSelectedMenu(int menu) => selectedMenu = menu;
}
