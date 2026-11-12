
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'projects_screen.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _descriptionController =
  TextEditingController();

  String _category = 'Accessories';
  String _difficulty = 'Beginner';
  DateTime? _deadline;

  final List<String> _categories = [
    'Accessories',
    'Flowers',
    'Bags',
    'Clothing',
    'Toys',
    'Home Decor',
    'Other',
  ];

  final List<String> _difficulties = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              surface: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _deadline = selectedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _createProject() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final project = ProjectItem(
      name: _nameController.text.trim(),
      progress: 0,
      status: 'Planned',
      deadline: _deadline == null
          ? 'Not set'
          : _formatDate(_deadline!),
      color: AppColors.softPink,
      icon: Icons.favorite_border,
      category: _category,
      difficulty: _difficulty,
      description: _descriptionController.text.trim(),
    );

    Navigator.pop(context, project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create New Project'),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Let’s make something lovely!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add the details of your next crochet creation.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),

                const SizedBox(height: 25),

                _fieldLabel('Project Name'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    hint: 'e.g. Rose Crochet Tote',
                    icon: Icons.favorite_border,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a project name.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 22),

                _fieldLabel('Category'),
                const SizedBox(height: 9),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: _inputDecoration(
                    hint: 'Choose a category',
                    icon: Icons.category_outlined,
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _category = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 22),

                _fieldLabel('Difficulty Level'),
                const SizedBox(height: 9),
                DropdownButtonFormField<String>(
                  value: _difficulty,
                  decoration: _inputDecoration(
                    hint: 'Choose difficulty',
                    icon: Icons.bar_chart,
                  ),
                  items: _difficulties.map((difficulty) {
                    return DropdownMenuItem(
                      value: difficulty,
                      child: Text(difficulty),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _difficulty = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 22),

                _fieldLabel('Target Deadline'),
                const SizedBox(height: 9),
                InkWell(
                  onTap: _selectDeadline,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _deadline == null
                                ? 'Choose a target date'
                                : _formatDate(_deadline!),
                            style: TextStyle(
                              color: _deadline == null
                                  ? AppColors.secondaryText
                                  : AppColors.darkBrown,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                _fieldLabel('Project Description'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _inputDecoration(
                    hint: 'Write a little about your project...',
                    icon: Icons.edit_note,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _createProject,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Create Project'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBrown,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: AppColors.primary,
        size: 21,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }
}
