import 'package:endurance_mobile_app/pages/network/network_page.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/app/route_guard.dart';
import 'package:endurance_mobile_app/components/main_shell.dart';
import 'package:endurance_mobile_app/pages/chats/chat_detail_page.dart';
import 'package:endurance_mobile_app/pages/chats/chats_page.dart';
import 'package:endurance_mobile_app/pages/home/home_page.dart';
import 'package:endurance_mobile_app/pages/profile.dart';
import 'package:endurance_mobile_app/pages/splash.dart';
import 'package:endurance_mobile_app/pages/unauthorized.dart';
import 'package:endurance_mobile_app/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const home = 'home';
  static const chats = 'chats';
  static const chatDetail = 'chatDetail';
  static const network = 'network';
  static const profile = 'profile';
}

// Bridges GetX reactive state to GoRouter so the router re-evaluates its
// redirect whenever auth state or the initialization flag changes.
class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier() {
    final ctrl = Get.find<AuthController>();
    ever(ctrl.isInitializing, (_) => notifyListeners());
    ever(ctrl.isAuthenticated, (_) => notifyListeners());
    ever(ctrl.userRoles, (_) => notifyListeners());
  }
}

final _authNotifier = _AuthStateNotifier();

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  refreshListenable: _authNotifier,
  redirect: (context, state) {
    final ctrl = Get.find<AuthController>();
    final loc = state.matchedLocation;

    if (ctrl.isInitializing.value) {
      return loc == '/splash' ? null : '/splash';
    }

    if (loc == '/splash') {
      if (!ctrl.isAuthenticated.value) return '/welcome';
      return ctrl.isVeteran ? '/home' : '/unauthorized';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, _) => const SplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      redirect: RouteGuard.unauthenticatedOnly,
      builder: (_, _) => const WelcomePage(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: AppRoutes.home,
          redirect: RouteGuard.veteranOnly,
          builder: (_, _) => const HomePage(),
        ),
        GoRoute(
          path: '/chats',
          name: AppRoutes.chats,
          redirect: RouteGuard.veteranOnly,
          builder: (_, _) => const ChatsPage(),
        ),
        GoRoute(
          path: '/network',
          name: AppRoutes.network,
          redirect: RouteGuard.veteranOnly,
          builder: (_, _) => const NetworkPage(),
        ),
        GoRoute(
          path: '/profile',
          name: AppRoutes.profile,
          redirect: RouteGuard.veteranOnly,
          builder: (_, _) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/chats/:conversationId',
      name: AppRoutes.chatDetail,
      redirect: RouteGuard.veteranOnly,
      builder: (_, state) => ChatDetailPage(
        conversationId: state.pathParameters['conversationId']!,
      ),
    ),
    GoRoute(
      path: '/unauthorized',
      redirect: RouteGuard.authenticatedOnly,
      builder: (_, _) => const UnauthorizedPage(),
    ),
    GoRoute(
      path: '/:path(.*)',
      redirect: (context, state) {
        final ctrl = Get.find<AuthController>();
        if (!ctrl.isAuthenticated.value) return '/welcome';
        return ctrl.isVeteran ? '/home' : '/unauthorized';
      },
    ),
  ],
);

