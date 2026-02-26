import 'package:endurance_mobile_app/authentication/controller/auth_controller.dart';
import 'package:endurance_mobile_app/pages/landing.dart';
import 'package:endurance_mobile_app/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Bridges GetX reactive state to GoRouter's refreshListenable.
class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier() {
    final ctrl = Get.find<AuthController>();
    ever(ctrl.isAuthenticated, (_) => notifyListeners());
    ever(ctrl.isLoading, (_) => notifyListeners());
  }
}

final _authNotifier = _AuthStateNotifier();

final GoRouter router = GoRouter(
  initialLocation: '/login',
  refreshListenable: _authNotifier,
  redirect: (context, state) {
    final ctrl = Get.find<AuthController>();
    // While restoring session, stay put — don't redirect yet.
    if (ctrl.isLoading.value) return null;
    final isAuth = ctrl.isAuthenticated.value;
    final onLogin = state.matchedLocation == '/login';
    if (!isAuth && !onLogin) return '/login';
    if (isAuth && onLogin) return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const LandingPage(),
    ),
  ],
);
