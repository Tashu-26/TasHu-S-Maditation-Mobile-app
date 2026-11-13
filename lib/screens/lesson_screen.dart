
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LessonScreen extends StatefulWidget {
  final String lessonTitle;
  final String level;
  final String duration;
  final String description;
  final List<String> materials;
  final List<String> steps;

  const LessonScreen({
    super.key,
    this.lessonTitle = 'Single Crochet Stitch',
    this.level = 'Beginner',
    this.duration = '10 minutes',
    this.description =
    'Learn one of the most important basic crochet stitches. '
        'Follow each step slowly and practice until you feel comfortable.',
    this.materials = const [
      'Medium-weight yarn',
      '4 mm crochet hook',
      'Scissors',
      'Yarn needle',
    ],
    this.steps = const [
      'Start with a slip knot and make a foundation chain.',
      'Insert your hook into the second chain from the hook.',
      'Yarn over and pull the yarn through the chain. '
          'You should now have two loops on your hook.',
      'Yarn over again and pull through both loops.',
      'Repeat the same process across the foundation chain.',
      'Continue practicing until your stitches look even.',
    ],
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final Set<int> _completedSteps = {};

  @override
  Widget build(BuildContext context) {
    final progress = widget.steps.isEmpty
        ? 0.0
        : _completedSteps.length / widget.steps.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Lesson Details',
          style: TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLessonHeader(),
            const SizedBox(height: 24),
            _buildProgressCard(progress),
            const SizedBox(height: 28),
            _buildSectionTitle('About this lesson'),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 28),
            _buildSectionTitle('What you will need'),
            const SizedBox(height: 12),
            _buildMaterials(),
            const SizedBox(height: 28),
            _buildSectionTitle('Step-by-step tutorial'),
            const SizedBox(height: 8),
            const Text(
              'Follow the steps and mark each one as complete.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 16),
            _buildSteps(),
            const SizedBox(height: 24),
            _buildTipCard(),
            const SizedBox(height: 24),
            _buildCompleteButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              size: 38,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.lessonTitle,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(Icons.signal_cellular_alt, widget.level),
              const SizedBox(width: 10),
              _buildInfoChip(Icons.access_time, widget.duration),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your lesson progress',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBrown,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: AppColors.cream,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_completedSteps.length} of ${widget.steps.length} steps completed',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget _buildMaterials() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: widget.materials.map((material) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.sageGreen,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    material,
                    style: const TextStyle(
                      color: AppColors.darkBrown,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSteps() {
    return Column(
      children: List.generate(widget.steps.length, (index) {
        final isCompleted = _completedSteps.contains(index);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCompleted
                  ? AppColors.sageGreen
                  : AppColors.border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.sageGreen
                      : AppColors.cream,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.steps[index],
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.darkBrown,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              Checkbox(
                value: isCompleted,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _completedSteps.add(index);
                    } else {
                      _completedSteps.remove(index);
                    }
                  });
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: AppColors.primary,
            size: 25,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crochet tip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Keep your yarn tension consistent. '
                      'Do not pull the yarn too tightly, especially '
                      'when you are just starting.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    final allCompleted = widget.steps.isNotEmpty &&
        _completedSteps.length == widget.steps.length;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: allCompleted
            ? () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Great job! Lesson completed.'),
            ),
          );
        }
            : null,
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('Complete Lesson'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.secondaryText,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
