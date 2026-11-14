
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'yarn_stash_screen.dart';
import 'pattern_finder_screen.dart';
import 'projects_screen.dart';
import 'color_helper_screen.dart';
import 'cost_calculator_screen.dart';
import 'learn_screen.dart';
import 'tutorial_simplifier_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature is coming soon! 🌷'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning, Tashu 🌷',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Ready to create something lovely?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.cream,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _showComingSoon(context, 'Notifications');
                      },
                      icon: const Icon(
                        Icons.notifications_none,
                        color: AppColors.primary,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // WELCOME BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: AppColors.softPink,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your cozy corner',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Make Something\nLovely',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A little yarn, a little patience,\nand a lot of creativity.',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {
                        _openScreen(
                          context,
                          const PatternFinderScreen(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBrown,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Explore Patterns'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // CONTINUE CREATING
              _sectionTitle(
                'Continue Creating',
                'Pick up where you left off',
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _projectCard(
                      context,
                      name: 'Rose Bloom Tote',
                      progress: 68,
                      deadline: 'Nov 12',
                      color: AppColors.softPink,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _projectCard(
                      context,
                      name: 'Baby Blanket',
                      progress: 35,
                      deadline: 'Dec 1',
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // CROCHET TOOLS
              _sectionTitle(
                'Your Crochet Tools',
                'Everything you need in one place',
              ),

              const SizedBox(height: 15),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _toolCard(
                    context,
                    title: 'Yarn Inventory',
                    subtitle: 'Manage your yarn stash',
                    icon: Icons.inventory_2_outlined,
                    color: AppColors.softPink,
                    onTap: () {
                      _openScreen(
                        context,
                        const YarnStashScreen(),
                      );
                    },
                  ),

                  _toolCard(
                    context,
                    title: 'Row Counter',
                    subtitle: 'Track your crochet rows',
                    icon: Icons.calculate_outlined,
                    color: AppColors.cream,
                    onTap: () {
                      _showComingSoon(context, 'Row Counter');
                    },
                  ),

                  // COLOR STUDIO
                  _toolCard(
                    context,
                    title: 'Color Studio',
                    subtitle: 'Explore color combinations',
                    icon: Icons.palette_outlined,
                    color: AppColors.sageGreen,
                    onTap: () {
                      _openScreen(
                        context,
                        const ColorHelperScreen(),
                      );
                    },
                  ),

                  // COST CALCULATOR
                  _toolCard(
                    context,
                    title: 'Cost Calculator',
                    subtitle: 'Calculate project costs',
                    icon: Icons.calculate,
                    color: const Color(0xFFE3C9A8),
                    onTap: () {
                      _openScreen(
                        context,
                        const CostCalculatorScreen(),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // BEGINNER PATTERNS
              _sectionTitle(
                'Made for You',
                'Start with something simple',
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.local_florist,
                        size: 45,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cute Crochet Flowers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Beginner friendly • 1 hour',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'A lovely little project to try!',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _openScreen(
                          context,
                          const PatternFinderScreen(),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primary,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // LEARNING SECTION
              _sectionTitle(
                'Learn Something New',
                'Grow your crochet skills',
              ),

              const SizedBox(height: 15),

              // LEARN CROCHET - CONNECTED
              _learningCard(
                context,
                title: 'Learn Crochet',
                subtitle: 'Step-by-step crochet lessons',
                icon: Icons.school_outlined,
                color: AppColors.sageGreen,
                onTap: () {
                  _openScreen(
                    context,
                    const LearnScreen(),
                  );
                },
              ),

              const SizedBox(height: 12),

              // TUTORIAL SIMPLIFIER
              _learningCard(
                context,
                title: 'Tutorial Simplifier',
                subtitle: 'Make difficult patterns easier',
                icon: Icons.auto_awesome_outlined,
                color: AppColors.softPink,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TutorialSimplifierScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // MY PROJECTS SHORTCUT
              _sectionTitle(
                'Your Creative Journey',
                'Keep making beautiful things',
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.folder_open_outlined,
                      size: 38,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Projects',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Manage your handmade creations.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _openScreen(
                          context,
                          const ProjectsScreen(),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primary,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Made with love and yarn ♡',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  // PROJECT CARD
  Widget _projectCard(
      BuildContext context, {
        required String name,
        required int progress,
        required String deadline,
        required Color color,
      }) {
    return GestureDetector(
      onTap: () {
        _openScreen(
          context,
          const ProjectsScreen(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Due: $deadline',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 7,
                backgroundColor: AppColors.cream,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$progress% completed',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TOOL CARD
  Widget _toolCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.darkBrown,
                size: 23,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // LEARNING CARD
  Widget _learningCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: AppColors.darkBrown,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
