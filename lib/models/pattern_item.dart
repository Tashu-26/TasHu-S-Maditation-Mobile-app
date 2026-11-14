
import 'package:flutter/material.dart';

class PatternItem {
  final String name;
  final String category;
  final String difficulty;
  final String duration;
  final IconData icon;
  final Color color;
  final int popularity;

  const PatternItem({
    required this.name,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.icon,
    required this.color,
    required this.popularity,
  });

  double get durationHours {
    final number = double.tryParse(duration.split(' ').first) ?? 0;
    return duration.contains('min') ? number / 60 : number;
  }
}

class PatternCatalog {
  static final List<PatternItem> patterns = [
    const PatternItem(
      name: 'Daisy Coaster',
      category: 'Flowers',
      difficulty: 'Beginner',
      duration: '1 hr',
      icon: Icons.local_florist,
      color: Color(0xFFE9B3C0),
      popularity: 1,
    ),
    const PatternItem(
      name: 'Mini Market Tote',
      category: 'Bags',
      difficulty: 'Intermediate',
      duration: '6 hrs',
      icon: Icons.shopping_bag_outlined,
      color: Color(0xFFE8D5C4),
      popularity: 2,
    ),
    const PatternItem(
      name: 'Bunny Amigurumi',
      category: 'Toys',
      difficulty: 'Intermediate',
      duration: '8 hrs',
      icon: Icons.cruelty_free_outlined,
      color: Color(0xFFFBE3EA),
      popularity: 3,
    ),
    const PatternItem(
      name: 'Bow Headband',
      category: 'Accessories',
      difficulty: 'Beginner',
      duration: '2 hrs',
      icon: Icons.favorite_border,
      color: Color(0xFFB96F83),
      popularity: 4,
    ),
    const PatternItem(
      name: 'Granny Square Cushion',
      category: 'Home Decor',
      difficulty: 'Beginner',
      duration: '5 hrs',
      icon: Icons.weekend_outlined,
      color: Color(0xFFE3C9A8),
      popularity: 5,
    ),
    const PatternItem(
      name: 'Cardigan Vest',
      category: 'Clothing',
      difficulty: 'Advanced',
      duration: '20 hrs',
      icon: Icons.checkroom_outlined,
      color: Color(0xFFB9CBB5),
      popularity: 6,
    ),
  ];
}

class SavedPatternsStore extends ChangeNotifier {
  SavedPatternsStore._();

  static final SavedPatternsStore instance = SavedPatternsStore._();

  final Set<String> _savedPatternNames = {};

  bool isSaved(String patternName) {
    return _savedPatternNames.contains(patternName);
  }

  List<PatternItem> get savedPatterns {
    return PatternCatalog.patterns
        .where((pattern) => _savedPatternNames.contains(pattern.name))
        .toList();
  }

  void toggle(PatternItem pattern) {
    if (isSaved(pattern.name)) {
      _savedPatternNames.remove(pattern.name);
    } else {
      _savedPatternNames.add(pattern.name);
    }

    notifyListeners();
  }

  void remove(String patternName) {
    _savedPatternNames.remove(patternName);
    notifyListeners();
  }
}
