import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/phone_entry_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/profile_registration_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/properties_list_screen.dart';
import 'screens/property_details_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyumba',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const AppRouter(),
      routes: {
        '/properties': (context) => const PropertiesListScreen(),
        '/property-details': (context) => const PropertyDetailsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Show splash for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showSplash = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show splash screen for 2 seconds
    if (_showSplash) {
      return const SplashScreen();
    }

    // After splash, show auth flow
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (!authProvider.state.isOtpSent) {
          return const PhoneEntryScreen();
        } else if (authProvider.state.isOtpSent && !authProvider.state.isVerified) {
          return const OTPVerificationScreen();
        } else if (authProvider.state.isVerified && !authProvider.isRegistered) {
          return const ProfileRegistrationScreen();
        } else if (authProvider.state.isVerified && authProvider.isRegistered) {
          return const DashboardScreen();
        } else {
          return const PhoneEntryScreen();
        }
      },
    );
  }
}
