
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ColorHelperScreen extends StatefulWidget {
  const ColorHelperScreen({super.key});

  @override
  State<ColorHelperScreen> createState() =>
      _ColorHelperScreenState();
}

class _ColorHelperScreenState extends State<ColorHelperScreen> {
  double _hue = 340;
  String _mode = 'Analogous';

  final List<List<Color>> _savedPalettes = [];

  Color get _mainColor {
    return HSLColor.fromAHSL(
      1,
      _hue,
      0.48,
      0.72,
    ).toColor();
  }

  List<Color> get _palette {
    List<double> offsets;

    switch (_mode) {
      case 'Complementary':
        offsets = [0, 180, 160, 200, 20];
        break;
      case 'Triadic':
        offsets = [0, 120, 240, 60, 180];
        break;
      default:
        offsets = [0, 30, -30, 60, -60];
    }

    return offsets.map((offset) {
      final hue = (_hue + offset) % 360;

      return HSLColor.fromAHSL(
        1,
        hue < 0 ? hue + 360 : hue,
        0.48,
        offset == 0 ? 0.72 : 0.80,
      ).toColor();
    }).toList();
  }

  String _hex(Color color) {
    return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }

  void _generateAnother() {
    setState(() {
      _hue = (_hue + 35) % 360;
    });
  }

  void _savePalette() {
    setState(() {
      _savedPalettes.insert(0, List<Color>.from(_palette));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Palette saved successfully!'),
      ),
    );
  }

  void _deletePalette(int index) {
    setState(() {
      _savedPalettes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = _palette;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Color Helper'),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find Your Perfect Colors',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Create beautiful color combinations for your next crochet project.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 25),

              _sectionTitle('Your Color Palette'),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: colors.asMap().entries.map((entry) {
                        final index = entry.key;
                        final color = entry.value;
                        final isMain = index == 0;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: isMain ? 68 : 52,
                                height: isMain ? 100 : 75,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.border,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isMain ? 'Main' : 'Color ${index + 1}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isMain
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      '${_mode} Color Combination',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              _sectionTitle('Choose Combination Style'),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Analogous',
                  'Complementary',
                  'Triadic',
                ].map((mode) {
                  final selected = _mode == mode;

                  return ChoiceChip(
                    label: Text(mode),
                    selected: selected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                    side: BorderSide.none,
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.white
                          : AppColors.darkBrown,
                    ),
                    onSelected: (_) {
                      setState(() {
                        _mode = mode;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              _sectionTitle('Choose Your Main Color'),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Adjust color hue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkBrown,
                          ),
                        ),
                        Text(
                          '${_hue.round()}°',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _hue,
                      min: 0,
                      max: 359,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.softPink,
                      onChanged: (value) {
                        setState(() {
                          _hue = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: _mainColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selected Main Color',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            Text(
                              _hex(_mainColor),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              _sectionTitle('Color Details'),
              const SizedBox(height: 12),

              ...colors.asMap().entries.map((entry) {
                final index = entry.key;
                final color = entry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              index == 0
                                  ? 'Main Color'
                                  : 'Matching Color ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkBrown,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _hex(color),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _generateAnother,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Generate Another'),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _savePalette,
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('Save Palette'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle('Saved Palettes'),
              const SizedBox(height: 12),

              if (_savedPalettes.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.palette_outlined,
                        size: 42,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No saved palettes yet',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Create a color combination and save it here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._savedPalettes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final palette = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: palette.map((color) {
                              return Expanded(
                                child: Container(
                                  height: 43,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Delete palette',
                          onPressed: () => _deletePalette(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }
}
