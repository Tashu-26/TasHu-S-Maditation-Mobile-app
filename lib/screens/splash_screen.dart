
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _getStarted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Welcome! Your onboarding screen is coming next.'),
        backgroundColor: AppColors.darkBrown,
      ),
    );
  }

  Widget _yarnBall({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 0.9,
          colors: [
            Colors.white.withValues(alpha: 0.75),
            color,
            color.withValues(alpha: 0.75),
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(4, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.cyclone_rounded,
        size: size * 0.72,
        color: Colors.white.withValues(alpha: 0.55),
      ),
    );
  }

  Widget _featureChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.darkBrown,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F4),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, _) {
            return Stack(
              children: [
                // Soft background decoration
                Positioned(
                  top: 35,
                  left: -45,
                  child: _yarnBall(
                    size: 170,
                    color: AppColors.softPink,
                  ),
                ),
                Positioned(
                  top: 75,
                  right: -35,
                  child: _yarnBall(
                    size: 125,
                    color: AppColors.cream,
                  ),
                ),
                Positioned(
                  bottom: 65,
                  right: -30,
                  child: _yarnBall(
                    size: 145,
                    color: AppColors.primary,
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: -25,
                  child: _yarnBall(
                    size: 105,
                    color: AppColors.softPink,
                  ),
                ),

                // Main splash content
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 440,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 30,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.68),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.9),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(
                                alpha: 0.13,
                              ),
                              blurRadius: 30,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // App icon / logo placeholder
                            Container(
                              width: 112,
                              height: 112,
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
                                size: 65,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 22),

                            const Text(
                              'TasHu\'S Maditation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                                letterSpacing: -0.6,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Smart Crochet Companion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 9),

                            const Text(
                              'Your little world of crochet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.secondaryText,
                              ),
                            ),

                            const SizedBox(height: 23),

                            // Feature chips
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 9,
                              children: [
                                _featureChip('Patterns'),
                                _featureChip('Yarn Stash'),
                                _featureChip('Projects'),
                                _featureChip('Color Helper'),
                                _featureChip('Cost ৳'),
                                _featureChip('Tutorial Simplifier'),
                              ],
                            ),

                            const SizedBox(height: 25),

                            // Decorative loading indicator
                            SizedBox(
                              width: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const LinearProgressIndicator(
                                  value: 0.6,
                                  minHeight: 6,
                                  backgroundColor: AppColors.softPink,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Get Started button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () => _getStarted(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  elevation: 5,
                                  shadowColor: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
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
                                    SizedBox(width: 9),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
