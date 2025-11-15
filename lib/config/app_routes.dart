import 'package:flutter/widgets.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/edit_profile_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';

  static Map<String, WidgetBuilder> routes = {
    home: (BuildContext context) => const HomeScreen(),
    profile: (BuildContext context) => const ProfileScreen(),
    editProfile: (BuildContext context) => const EditProfileScreen(),
  };
}
