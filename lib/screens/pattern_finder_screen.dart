
import 'package:flutter/material.dart';

import '../models/pattern_item.dart';
import '../theme/app_colors.dart';
import 'pattern_details_screen.dart';

class PatternFinderScreen extends StatefulWidget {
  const PatternFinderScreen({super.key});

  @override
  State<PatternFinderScreen> createState() =>
      _PatternFinderScreenState();
}

class _PatternFinderScreenState extends State<PatternFinderScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  String _selectedCategory = 'All';
  String _selectedDifficulty = 'All';
  String _sortBy = 'Popular';

  final List<String> _categories = [
    'All',
    'Flowers',
    'Bags',
    'Accessories',
    'Clothing',
    'Toys',
    'Home Decor',
  ];

  final List<String> _difficulties = [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PatternItem> get _filteredPatterns {
    final query = _searchController.text.toLowerCase();

    List<PatternItem> results =
    PatternCatalog.patterns.where((pattern) {
      final matchesSearch =
          pattern.name.toLowerCase().contains(query) ||
              pattern.category.toLowerCase().contains(query);

      final matchesCategory =
          _selectedCategory == 'All' ||
              pattern.category == _selectedCategory;

      final matchesDifficulty =
          _selectedDifficulty == 'All' ||
              pattern.difficulty == _selectedDifficulty;

      return matchesSearch &&
          matchesCategory &&
          matchesDifficulty;
    }).toList();

    if (_sortBy == 'Name A-Z') {
      results.sort((a, b) => a.name.compareTo(b.name));
    } else if (_sortBy == 'Quickest') {
      results.sort(
            (a, b) => a.durationHours.compareTo(b.durationHours),
      );
    } else {
      results.sort(
            (a, b) => a.popularity.compareTo(b.popularity),
      );
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final patterns = _filteredPatterns;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Find Your Next Project',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Discover something lovely to crochet.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 20),

              // Search bar
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search patterns...',
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryText,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Categories
              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final selected =
                        _selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.white,
                      labelStyle: TextStyle(
                        color: selected
                            ? AppColors.white
                            : AppColors.darkBrown,
                        fontWeight: FontWeight.w500,
                      ),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Difficulty filters
              const Text(
                'Skill Level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _difficulties.map((difficulty) {
                  final selected =
                      _selectedDifficulty == difficulty;

                  return ChoiceChip(
                    label: Text(difficulty),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedDifficulty = difficulty;
                      });
                    },
                    selectedColor: AppColors.cream,
                    backgroundColor: AppColors.white,
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.primary
                          : AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide(
                      color: selected
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 22),

              // Results heading and sorting
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Crochet Patterns (${patterns.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        _sortBy = value;
                      });
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'Popular',
                        child: Text('Popular'),
                      ),
                      PopupMenuItem(
                        value: 'Name A-Z',
                        child: Text('Name A-Z'),
                      ),
                      PopupMenuItem(
                        value: 'Quickest',
                        child: Text('Quickest first'),
                      ),
                    ],
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sort,
                          color: AppColors.primary,
                          size: 19,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _sortBy,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Pattern cards
              if (patterns.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: AppColors.secondaryText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No patterns found',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.darkBrown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Try another search or filter.',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
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

                    return _buildPatternCard(pattern);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatternCard(PatternItem pattern) {
    final isSaved =
    SavedPatternsStore.instance.isSaved(pattern.name);

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
                        icon: Icon(
                          isSaved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isSaved
                              ? AppColors.primary
                              : AppColors.darkBrown,
                          size: 19,
                        ),
                        onPressed: () {
                          SavedPatternsStore.instance.toggle(pattern);

                          setState(() {});
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
