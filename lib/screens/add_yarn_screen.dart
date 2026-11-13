
import 'package:flutter/material.dart';

import '../models/yarn_item.dart';
import '../theme/app_colors.dart';

class AddYarnScreen extends StatefulWidget {
  const AddYarnScreen({super.key});

  @override
  State<AddYarnScreen> createState() => _AddYarnScreenState();
}

class _AddYarnScreenState extends State<AddYarnScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _quantityController = TextEditingController();

  String _selectedCategory = 'Cotton';
  String _selectedColor = 'Blush Pink';

  final List<String> _categories = [
    'Cotton',
    'Acrylic',
    'Velvet',
    'Wool',
    'Other',
  ];

  final Map<String, Color> _availableColors = {
    'Blush Pink': const Color(0xFFE9B3C0),
    'Cream': const Color(0xFFFFF0E8),
    'Sage Green': const Color(0xFFB9CBB5),
    'Beige': const Color(0xFFE3C9A8),
    'Brown': const Color(0xFF92766A),
    'White': const Color(0xFFFFFFFF),
    'Black': const Color(0xFF49352F),
  };

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _colorController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addYarn() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newYarn = YarnItem(
      name: _nameController.text.trim(),
      brand: _brandController.text.trim().isEmpty
          ? 'Unknown brand'
          : _brandController.text.trim(),
      colorName: _colorController.text.trim().isEmpty
          ? _selectedColor
          : _colorController.text.trim(),
      quantity: int.parse(_quantityController.text.trim()),
      unit: 'balls',
      category: _selectedCategory,
      color: _availableColors[_selectedColor]!,
    );

    Navigator.pop(context, newYarn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add New Yarn'),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Grow Your Yarn Collection',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add the details of your new yarn below.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 25),

                _sectionTitle('Yarn Information'),
                const SizedBox(height: 14),

                _textField(
                  controller: _nameController,
                  label: 'Yarn name',
                  hint: 'Example: Soft Cotton',
                  icon: Icons.spa_outlined,
                  requiredField: true,
                ),
                const SizedBox(height: 16),

                _textField(
                  controller: _brandController,
                  label: 'Brand',
                  hint: 'Example: Milk Cotton',
                  icon: Icons.business_outlined,
                ),
                const SizedBox(height: 16),

                _textField(
                  controller: _colorController,
                  label: 'Color name (optional)',
                  hint: 'Leave blank to use the selected color',
                  icon: Icons.palette_outlined,
                ),
                const SizedBox(height: 22),

                _sectionTitle('Yarn Category'),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: _inputDecoration(
                    'Select category',
                    Icons.category_outlined,
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
                        _selectedCategory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 22),

                _sectionTitle('Choose Yarn Color'),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _availableColors.entries.map((entry) {
                    final selected = _selectedColor == entry.key;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = entry.key;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: entry.value,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: selected ? 3 : 1,
                              ),
                            ),
                            child: selected
                                ? const Icon(
                              Icons.check,
                              color: AppColors.darkBrown,
                              size: 20,
                            )
                                : null,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),

                _sectionTitle('Stock Quantity'),
                const SizedBox(height: 12),

                _textField(
                  controller: _quantityController,
                  label: 'Quantity (number of balls)',
                  hint: 'Example: 5',
                  icon: Icons.inventory_2_outlined,
                  requiredField: true,
                  isNumber: true,
                ),
                const SizedBox(height: 8),
                const Text(
                  'You can update your stock quantity later.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _addYarn,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Yarn to My Stash'),
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
                      side: const BorderSide(color: AppColors.primary),
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

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool requiredField = false,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
      isNumber ? TextInputType.number : TextInputType.text,
      decoration: _inputDecoration(label, icon).copyWith(
        hintText: hint,
      ),
      validator: (value) {
        if (requiredField && (value == null || value.trim().isEmpty)) {
          return 'Please enter $label';
        }

        if (isNumber && value != null && value.trim().isNotEmpty) {
          final quantity = int.tryParse(value.trim());

          if (quantity == null || quantity < 0) {
            return 'Enter a valid quantity (0 or more)';
          }
        }

        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: AppColors.white,
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
