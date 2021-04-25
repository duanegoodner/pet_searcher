import '../screens/account_setup_screen.dart';
import '../screens/add_pet_screen.dart';
import '../screens/admin_home_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/login_screen.dart';
import '../screens/user_home_screen_UI.dart';

class RouteNames {
  static final routes = {
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
    AddPetScreen.routeName: (context) => AddPetScreen(),
    UserHomeScreen.routeName: (context) => UserHomeScreen(),
    AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
  };
}
