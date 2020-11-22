import 'package:inno_russian/main_screen.dart';

import 'MainSreens/menu.dart';
import 'MainSreens/settings.dart';
import 'MainSreens/vocabulary.dart';

class NavigationButton {

  static String token;


  static final tabsScreens = [Menu(token), Vocabulary(), Settings()];

}