
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative yarn balls
            Positioned(
              top: 35,
              left: -35,
              child: _yarnBall(
                color: AppColors.softPink,
                size: 105,
              ),
            ),
            Positioned(
              top: 100,
              right: -40,
              child: _yarnBall(
                color: AppColors.beige,
                size: 115,
              ),
            ),
            Positioned(
              bottom: 120,
              left: -45,
              child: _yarnBall(
                color: AppColors.sageGreen,
                size: 110,
              ),
            ),
            Positioned(
              bottom: 45,
              right: -35,
              child: _yarnBall(
                color: AppColors.softPink,
                size: 90,
              ),
            ),

            // Main splash content
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),

                      // Logo container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(
                                alpha: 0.10,
                              ),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/tashus_logo.png',
                          width: 310,
                          height: 310,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 310,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 55,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // App name
                      const Text(
                        "TasHu'S Maditation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Smart Crochet Companion',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Your little world of crochet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Feature chips
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 9,
                        runSpacing: 10,
                        children: const [
                          _FeatureChip(
                            icon: Icons.auto_awesome,
                            label: 'Patterns',
                          ),
                          _FeatureChip(
                            icon: Icons.inventory_2_outlined,
                            label: 'Yarn Stash',
                          ),
                          _FeatureChip(
                            icon: Icons.work_outline,
                            label: 'Projects',
                          ),
                          _FeatureChip(
                            icon: Icons.palette_outlined,
                            label: 'Color Helper',
                          ),
                          _FeatureChip(
                            icon: Icons.calculate_outlined,
                            label: 'Cost Calculator',
                          ),
                          _FeatureChip(
                            icon: Icons.menu_book_outlined,
                            label: 'Tutorial Simplifier',
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Decorative progress indicator
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

                      const SizedBox(height: 25),

                      // Get Started button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
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
                            foregroundColor: AppColors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Made with love for crochet lovers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Decorative yarn ball widget
  Widget _yarnBall({
    required Color color,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.20),
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.cyclone_rounded,
        size: size * 0.65,
        color: color.withValues(alpha: 0.65),
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
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
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
            size: 15,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
        ],
      ),
    );
  }
}
