import 'package:endure_mobile_app/features/landing/presentation/pages/landing_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/landing",
  routes: [
    GoRoute(path: "/landing", builder: (context, state) => const LandingPage()),
  ],
);
