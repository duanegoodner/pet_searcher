
import '../screens/animal_detail_screen.dart';
import '../navigation/startup_screen_controller.dart';
import '../screens/account_setup_screen.dart';
import '../screens/add_news_item_screen.dart';
import '../screens/add_pet_screen.dart';
import '../screens/admin_home_screen.dart';
import '../screens/animal_inventory_screen.dart';
import '../screens/choose_animal_type_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/login_screen.dart';
import '../screens/news_screen.dart';
import '../screens/user_home_screen.dart';
import '../screens/favorite_screen.dart';

class RouteNames {
  static final routes = {
    StartUpScreenController.routeName: (context) => StartUpScreenController(),
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
    AddPetScreen.routeName: (context) => AddPetScreen(),
    ChooseAnimalTypeScreen.routeName: (context) => ChooseAnimalTypeScreen(),
    UserHomeScreen.routeName: (context) => UserHomeScreen(),
    AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
    AddNewsItemScreen.routeName: (context) => AddNewsItemScreen(),
    AnimalInventoryScreen.routeName: (context) => AnimalInventoryScreen(),
    AnimalDetailScreen.routename: (context) => AnimalDetailScreen(),
    NewsScreen.routeName: (context) => NewsScreen(),
    FavoriteScreen.routeName: (context) => FavoriteScreen(),
  };
}
