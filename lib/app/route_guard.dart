import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Provides reusable route-level redirect callbacks for GoRouter.
///
/// Usage — attach directly to a [GoRoute]'s `redirect` parameter:
/// ```dart
/// GoRoute(
///   path: '/home',
///   redirect: RouteGuard.veteranOnly,
///   builder: (_, _) => const HomePage(),
/// )
/// ```
abstract final class RouteGuard {
  /// Allows any authenticated user.
  /// Redirects to [/welcome] if not logged in.
  static String? authenticatedOnly(BuildContext context, GoRouterState state) {
    final ctrl = Get.find<AuthController>();
    if (!ctrl.isAuthenticated.value) return '/welcome';
    return null;
  }

  /// Allows only authenticated users with the `veteran` role.
  /// Redirects to [/welcome] if not logged in, or [/unauthorized] if wrong role.
  static String? veteranOnly(BuildContext context, GoRouterState state) {
    final ctrl = Get.find<AuthController>();
    if (!ctrl.isAuthenticated.value) return '/welcome';
    if (!ctrl.isVeteran) return '/unauthorized';
    return null;
  }

  /// Allows only unauthenticated users (e.g. the welcome page).
  /// Redirects authenticated veterans to [/home] and others to [/unauthorized].
  static String? unauthenticatedOnly(
    BuildContext context,
    GoRouterState state,
  ) {
    final ctrl = Get.find<AuthController>();
    if (!ctrl.isAuthenticated.value) return null;
    return ctrl.isVeteran ? '/home' : '/unauthorized';
  }
}
