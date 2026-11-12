
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'projects_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectItem project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState
    extends State<ProjectDetailsScreen> {
  late double _progress;
  late String _status;

  final TextEditingController _notesController =
  TextEditingController();

  final List<String> _materials = [
    'Crochet hook',
    'Yarn',
    'Scissors',
    'Stitch markers',
    'Yarn needle',
  ];

  final Set<String> _checkedMaterials = {};

  @override
  void initState() {
    super.initState();

    _progress = widget.project.progress.toDouble();
    _status = widget.project.status;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _updateProgress(double value) {
    setState(() {
      _progress = value;

      if (_progress == 100) {
        _status = 'Completed';
      } else if (_progress > 0) {
        _status = 'In Progress';
      } else {
        _status = 'Planned';
      }
    });
  }

  void _markCompleted() {
    setState(() {
      _progress = 100;
      _status = 'Completed';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project marked as completed! 🌷'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Project header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: project.color.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        project.icon,
                        size: 55,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _status,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Progress section
              _sectionTitle('Project Progress'),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your progress',
                          style: TextStyle(
                            color: AppColors.darkBrown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${_progress.round()}%',
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _progress,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      activeColor: AppColors.primary,
                      onChanged: _updateProgress,
                    ),
                    const Text(
                      'Move the slider to update your progress.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progress / 100,
                        minHeight: 9,
                        backgroundColor: AppColors.cream,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _markCompleted,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Mark as Completed'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Materials checklist
              _sectionTitle('Materials Checklist'),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    ..._materials.map((material) {
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColors.primary,
                        title: Text(
                          material,
                          style: const TextStyle(
                            color: AppColors.darkBrown,
                          ),
                        ),
                        value: _checkedMaterials.contains(material),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _checkedMaterials.add(material);
                            } else {
                              _checkedMaterials.remove(material);
                            }
                          });
                        },
                      );
                    }),
                    const Divider(color: AppColors.border),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${_checkedMaterials.length} of ${_materials.length} materials ready',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Notes section
              _sectionTitle('Project Notes'),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: TextField(
                  controller: _notesController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText:
                    'Write your ideas, reminders, or project notes...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: AppColors.darkBrown,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Deadline
              _sectionTitle('Project Deadline'),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Target date',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.deadline,
                          style: const TextStyle(
                            color: AppColors.darkBrown,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.border),
    );
  }
}
