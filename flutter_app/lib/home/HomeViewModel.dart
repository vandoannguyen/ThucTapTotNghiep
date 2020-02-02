//class to save data of screen
class HomeViewModel {
  int _curentIndexNavBar;

  HomeViewModel() {
    _curentIndexNavBar = 0;
  }

  int get curentIndexNavBar => _curentIndexNavBar;

  set curentIndexNavBar(int value) {
    _curentIndexNavBar = value;
  }
}
