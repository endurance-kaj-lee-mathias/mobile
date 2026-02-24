import 'package:go_router/go_router.dart';

import '../pages/landing.dart';

final GoRouter router = GoRouter(
  initialLocation: "/landing",
  routes: [
    GoRoute(path: "/landing", builder: (context, state) => const LandingPage()),
  ],
);
