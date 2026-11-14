
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F4),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),

                      // Decorative yarn balls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _yarnBall(
                            color: AppColors.softPink,
                            size: 65,
                          ),
                          _yarnBall(
                            color: AppColors.sageGreen,
                            size: 85,
                          ),
                          _yarnBall(
                            color: AppColors.beige,
                            size: 60,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Main logo card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 35,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.beige.withValues(alpha: 0.2),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 105,
                              width: 105,
                              decoration: BoxDecoration(
                                color: AppColors.cream,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.softPink,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.spa_rounded,
                                size: 58,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 25),

                            const Text(
                              "TasHu'S Maditation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'Smart Crochet Companion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 15),

                            const Text(
                              'Your little world of crochet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.secondaryText,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // App features
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 12,
                        children: const [
                          _FeatureChip(
                            icon: Icons.menu_book_rounded,
                            label: 'Patterns',
                          ),
                          _FeatureChip(
                            icon: Icons.inventory_2_rounded,
                            label: 'Yarn Stash',
                          ),
                          _FeatureChip(
                            icon: Icons.workspaces_rounded,
                            label: 'Projects',
                          ),
                          _FeatureChip(
                            icon: Icons.palette_rounded,
                            label: 'Color Helper',
                          ),
                          _FeatureChip(
                            icon: Icons.calculate_rounded,
                            label: 'Cost Calculator',
                          ),
                          _FeatureChip(
                            icon: Icons.auto_awesome_rounded,
                            label: 'Tutorial Simplifier',
                          ),
                        ],
                      ),

                      const SizedBox(height: 35),

                      // Loading-style progress indicator
                      SizedBox(
                        width: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: 0.6,
                            minHeight: 5,
                            backgroundColor: AppColors.cream,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Get Started button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const OnboardingScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Made with love and yarn ♡',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Decorative yarn ball widget
  static Widget _yarnBall({
    required Color color,
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: [
            color.withValues(alpha: 0.6),
            color,
            color.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: Icon(
        Icons.cyclone_rounded,
        size: size * 0.65,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }
}

// Feature chip widget
class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkBrown,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
