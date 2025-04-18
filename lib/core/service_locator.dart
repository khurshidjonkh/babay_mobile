import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/services/auth_service.dart';
import 'providers/auth_provider.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  // Register AuthService
  locator.registerSingleton<AuthService>(AuthService(locator<SharedPreferences>()));

  // Register AuthProvider
  locator.registerSingleton<AuthProvider>(AuthProvider(locator<AuthService>()));
}
