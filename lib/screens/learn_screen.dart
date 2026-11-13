
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'lesson_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int _selectedCategory = 0;

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Getting Started',
      'count': '3 lessons',
      'description': 'Learn the basics of crochet.',
      'icon': Icons.waving_hand_outlined,
      'color': AppColors.cream,
      'lessons': [
        'Introduction to Crochet',
        'Choosing Your Hook',
        'Holding Yarn and Hook',
      ],
    },
    {
      'name': 'Basic Stitches',
      'count': '5 lessons',
      'description': 'Practice essential crochet stitches.',
      'icon': Icons.grid_view_rounded,
      'color': AppColors.softPink,
      'lessons': [
        'Chain Stitch',
        'Single Crochet',
        'Half Double Crochet',
        'Double Crochet',
        'Slip Stitch',
      ],
    },
    {
      'name': 'Techniques',
      'count': '4 lessons',
      'description': 'Improve your crochet skills.',
      'icon': Icons.auto_awesome_outlined,
      'color': AppColors.sageGreen,
      'lessons': [
        'Making a Magic Ring',
        'Working in Rounds',
        'Joining Techniques',
        'Finishing Your Project',
      ],
    },
    {
      'name': 'Terminology',
      'count': '6 terms',
      'description': 'Understand common crochet words.',
      'icon': Icons.menu_book_outlined,
      'color': AppColors.beige,
      'lessons': [
        'CH — Chain',
        'SC — Single Crochet',
        'DC — Double Crochet',
        'HDC — Half Double Crochet',
        'SL ST — Slip Stitch',
        'YO — Yarn Over',
      ],
    },
  ];

  void _openLesson(String lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          lessonTitle: lesson,
          level: _selectedCategory == 0
              ? 'Beginner'
              : _selectedCategory == 1
              ? 'Beginner'
              : 'Intermediate',
          duration: '10 minutes',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = _categories[_selectedCategory];
    final lessons = category['lessons'] as List<String>;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Learn Crochet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Learn something beautiful',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Small lessons, one stitch at a time.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 22),

              // Continue learning card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'CONTINUE LEARNING',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.auto_stories_outlined,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 27,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Single Crochet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Continue where you left off',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              value: 0.60,
                              minHeight: 7,
                              backgroundColor: Color(0x55FFFFFF),
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '60%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _openLesson('Single Crochet'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                        child: const Text(
                          'Continue Lesson',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Learning progress
              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.emoji_events_outlined,
                        color: AppColors.primary,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 13),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Learning Progress',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '4 of 12 lessons completed',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '33%',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 27),

              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 13),

              // Category cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.12,
                ),
                itemBuilder: (context, index) {
                  final item = _categories[index];
                  final isSelected = _selectedCategory == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 1.8 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: const TextStyle(
                                  color: AppColors.darkBrown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['count'] as String,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 27),

              // Lesson list heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lessons',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  Text(
                    category['name'] as String,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Lesson list
              ...lessons.asMap().entries.map((entry) {
                final index = entry.key;
                final lesson = entry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.cream,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      lesson,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    onTap: () => _openLesson(lesson),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
