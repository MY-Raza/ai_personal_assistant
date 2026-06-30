import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/forgot_screen.dart';
import '../screens/otp_screen.dart';
import '../ui/main_shell.dart';
import '../screens/dashboard_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/search_screen.dart';
import '../screens/email_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/notifications_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/forgot',
      builder: (context, state) => const ForgotScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/weather',
          builder: (context, state) => const WeatherScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/email',
          builder: (context, state) => const EmailScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);