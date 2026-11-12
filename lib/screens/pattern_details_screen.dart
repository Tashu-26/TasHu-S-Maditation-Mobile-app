
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PatternDetailsScreen extends StatefulWidget {
  final String patternName;
  final String difficulty;
  final String duration;
  final IconData icon;
  final Color color;

  const PatternDetailsScreen({
    super.key,
    required this.patternName,
    required this.difficulty,
    required this.duration,
    required this.icon,
    required this.color,
  });

  @override
  State<PatternDetailsScreen> createState() =>
      _PatternDetailsScreenState();
}

class _PatternDetailsScreenState extends State<PatternDetailsScreen> {
  final Set<int> _checkedMaterials = {};
  bool _isSaved = false;

  final List<String> _materials = [
    'Cotton DK, rose — 30 g',
    'Cotton DK, cream — 10 g',
    '4 mm crochet hook',
    'Tapestry needle',
  ];

  @override
  Widget build(BuildContext context) {
    final isDaisy = widget.patternName == 'Daisy Coaster';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pattern Details'),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pattern image area
              Container(
                width: double.infinity,
                height: 210,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(
                  widget.icon,
                  size: 100,
                  color: AppColors.darkBrown.withValues(alpha: 0.65),
                ),
              ),

              const SizedBox(height: 18),

              // Pattern name
              Text(
                widget.patternName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 12),

              // Pattern information
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _infoChip(widget.difficulty),
                  _infoChip('⏱ ${widget.duration}'),
                  if (isDaisy) _infoChip('Hook 4 mm'),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                isDaisy
                    ? 'A quick round coaster with a cheerful flower center. Perfect for first projects.'
                    : 'A lovely crochet project to add to your handmade collection.',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 24),

              // Materials section
              _sectionTitle('Materials'),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  children: List.generate(
                    _materials.length,
                        (index) {
                      final checked = _checkedMaterials.contains(index);

                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.primary,
                        title: Text(
                          _materials[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkBrown,
                            decoration: checked
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        value: checked,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _checkedMaterials.add(index);
                            } else {
                              _checkedMaterials.remove(index);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Instructions section
              _sectionTitle('Instructions'),

              const SizedBox(height: 12),

              if (isDaisy) ...[
                _instructionStep(
                  '1',
                  'Make a magic ring, ch 2, work 12 dc into the ring.',
                ),
                _instructionStep(
                  '2',
                  'Work 2 dc in each stitch around (24 stitches). Join with sl st.',
                ),
                _instructionStep(
                  '3',
                  'Change to cream yarn and make the flower petals around the edge.',
                ),
                _instructionStep(
                  '4',
                  'Fasten off, weave in the loose ends, and gently shape your coaster.',
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: _cardDecoration(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abbreviations',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ch = chain\n'
                            'dc = double crochet\n'
                            'sl st = slip stitch',
                        style: TextStyle(
                          height: 1.7,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: _cardDecoration(),
                  child: const Text(
                    'Detailed instructions for this pattern will be added when its pattern guide is prepared.',
                    style: TextStyle(
                      height: 1.5,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Add to project button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Project creation will be connected next!',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add to My Projects'),
                ),
              ),

              const SizedBox(height: 10),

              // Save pattern button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isSaved = !_isSaved;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isSaved
                              ? 'Pattern saved!'
                              : 'Pattern removed from saved!',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    _isSaved ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    _isSaved ? 'Saved Pattern' : 'Save Pattern',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget _instructionStep(String number, String instruction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.cream,
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(
                height: 1.5,
                color: AppColors.darkBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border),
    );
  }
}
