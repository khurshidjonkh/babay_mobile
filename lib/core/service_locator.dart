import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/services/auth_service.dart';
import '../data/services/profile_service.dart';
import 'providers/auth_provider.dart';
import 'providers/profile_provider.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  // Register AuthService
  locator.registerSingleton<AuthService>(
    AuthService(locator<SharedPreferences>()),
  );

  // Register AuthProvider
  locator.registerSingleton<AuthProvider>(AuthProvider(locator<AuthService>()));

  // Register ProfileService
  locator.registerSingleton<ProfileService>(
    ProfileService(locator<SharedPreferences>()),
  );

  // Register ProfileProvider
  locator.registerSingleton<ProfileProvider>(
    ProfileProvider(locator<ProfileService>()),
  );
}
