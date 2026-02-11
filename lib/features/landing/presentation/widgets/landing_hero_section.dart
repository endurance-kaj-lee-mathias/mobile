import 'package:endure_mobile_app/app_components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LandingHeroSection extends StatelessWidget {
  const LandingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.7,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/logo.svg', width: 100, height: 100),
          SizedBox(height: 24),
          Text(
            'Endure',
            style: textTheme.displayLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Strength Beyond Service',
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Empowering military personnel with tools for resilience, fitness, and mental well-being.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
          ),
          SizedBox(height: 48),
          AppButton(text: "Get Started", onPressed: () => context.go('/login')),
        ],
      ),
    );
  }
}
