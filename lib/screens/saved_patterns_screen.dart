
import 'package:flutter/material.dart';

import '../models/pattern_item.dart';
import '../theme/app_colors.dart';
import 'pattern_details_screen.dart';

class SavedPatternsScreen extends StatelessWidget {
  const SavedPatternsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SavedPatternsStore.instance;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Saved Patterns',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, child) {
          final patterns = store.savedPatterns;

          if (patterns.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        color: AppColors.cream,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 55,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'No Saved Patterns Yet',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Explore crochet patterns and tap the heart '
                          'icon to save your favorites here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${patterns.length} favorite pattern'
                      '${patterns.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: patterns.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    final pattern = patterns[index];

                    return _buildPatternCard(context, pattern);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPatternCard(
      BuildContext context,
      PatternItem pattern,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatternDetailsScreen(
              patternName: pattern.name,
              difficulty: pattern.difficulty,
              duration: pattern.duration,
              icon: pattern.icon,
              color: pattern.color,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: pattern.color.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    pattern.icon,
                    size: 65,
                    color: AppColors.darkBrown.withValues(alpha: 0.65),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: AppColors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.primary,
                          size: 19,
                        ),
                        onPressed: () {
                          SavedPatternsStore.instance
                              .remove(pattern.name);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            pattern.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${pattern.difficulty} · ${pattern.duration}',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
