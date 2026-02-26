import 'package:endurance_mobile_app/authentication/controller/auth_controller.dart';
import 'package:endurance_mobile_app/pages/home.dart';
import 'package:endurance_mobile_app/pages/unauthorized.dart';
import 'package:endurance_mobile_app/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Bridges GetX reactive state to GoRouter's refreshListenable.
class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier() {
    final ctrl = Get.find<AuthController>();
    ever(ctrl.isAuthenticated, (_) => notifyListeners());
    ever(ctrl.isLoading, (_) => notifyListeners());
    ever(ctrl.userRoles, (_) => notifyListeners());
  }
}

final _authNotifier = _AuthStateNotifier();

final GoRouter router = GoRouter(
  initialLocation: '/welcome',
  refreshListenable: _authNotifier,
  redirect: (context, state) {
    final ctrl = Get.find<AuthController>();
    if (ctrl.isLoading.value) return null;

    final isAuth = ctrl.isAuthenticated.value;
    final loc = state.matchedLocation;

    if (!isAuth) {
      return loc == '/welcome' ? null : '/welcome';
    }

    if (ctrl.isVeteran) {
      if (loc == '/welcome' || loc == '/unauthorized') return '/home';
      return null;
    } else {
      return loc == '/unauthorized' ? null : '/unauthorized';
    }
  },
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/unauthorized',
      builder: (context, state) => const UnauthorizedPage(),
    ),
  ],
);
