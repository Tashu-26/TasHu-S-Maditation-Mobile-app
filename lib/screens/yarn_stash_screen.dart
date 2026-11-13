
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class YarnStashScreen extends StatefulWidget {
  const YarnStashScreen({super.key});

  @override
  State<YarnStashScreen> createState() => _YarnStashScreenState();
}

class _YarnStashScreenState extends State<YarnStashScreen> {
  String _selectedCategory = 'All';

  final List<YarnItem> _yarns = [
    YarnItem(
      name: 'Soft Cotton',
      brand: 'Milk Cotton',
      colorName: 'Blush Pink',
      quantity: 5,
      unit: 'balls',
      category: 'Cotton',
      color: const Color(0xFFE9B3C0),
    ),
    YarnItem(
      name: 'Everyday Acrylic',
      brand: 'DMC',
      colorName: 'Cream',
      quantity: 3,
      unit: 'balls',
      category: 'Acrylic',
      color: const Color(0xFFFFF0E8),
    ),
    YarnItem(
      name: 'Natural Cotton',
      brand: 'Cotton King',
      colorName: 'Sage Green',
      quantity: 4,
      unit: 'balls',
      category: 'Cotton',
      color: const Color(0xFFB9CBB5),
    ),
    YarnItem(
      name: 'Velvet Yarn',
      brand: 'Soft Touch',
      colorName: 'Brown',
      quantity: 2,
      unit: 'balls',
      category: 'Velvet',
      color: const Color(0xFFE3C9A8),
    ),
  ];

  final List<String> _categories = [
    'All',
    'Cotton',
    'Acrylic',
    'Velvet',
    'Wool',
    'Other',
  ];

  List<YarnItem> get _filteredYarns {
    if (_selectedCategory == 'All') {
      return _yarns;
    }

    return _yarns
        .where((yarn) => yarn.category == _selectedCategory)
        .toList();
  }

  int get _totalQuantity {
    return _yarns.fold(
      0,
          (total, yarn) => total + yarn.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final yarns = _filteredYarns;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Yarn Stash',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Keep your creative materials organized.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 22),

              // Inventory summary
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      'Yarn Types',
                      '${_yarns.length}',
                      Icons.inventory_2_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      'Total Stock',
                      '$_totalQuantity',
                      Icons.spa_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Filter heading
              const Text(
                'Yarn Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 12),

              // Category filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    final selected =
                        _selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.white,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          color: selected
                              ? AppColors.white
                              : AppColors.darkBrown,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 25),

              // Yarn list heading
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Collection',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  Text(
                    '${yarns.length} items',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (yarns.isEmpty)
                _emptyState()
              else
                ...yarns.map(_yarnCard),

              const SizedBox(height: 20),

              // Add yarn button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showAddYarnDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Yarn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(
      String title,
      String value,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 27,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _yarnCard(YarnItem yarn) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: yarn.color.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.spa_outlined,
              size: 32,
              color: AppColors.darkBrown,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  yarn.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${yarn.brand} • ${yarn.colorName}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  yarn.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Text(
                '${yarn.quantity}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                yarn.unit,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 19,
                    onPressed: () {
                      setState(() {
                        if (yarn.quantity > 0) {
                          yarn.quantity--;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 19,
                    onPressed: () {
                      setState(() {
                        yarn.quantity++;
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 50,
            color: AppColors.primary,
          ),
          SizedBox(height: 12),
          Text(
            'No yarn found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try another category or add new yarn.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddYarnDialog() {
    final nameController = TextEditingController();
    final brandController = TextEditingController();
    final colorController = TextEditingController();
    final quantityController = TextEditingController();

    String category = 'Cotton';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, updateDialog) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              title: const Text('Add New Yarn'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _dialogField(
                      nameController,
                      'Yarn name',
                    ),
                    const SizedBox(height: 12),
                    _dialogField(
                      brandController,
                      'Brand',
                    ),
                    const SizedBox(height: 12),
                    _dialogField(
                      colorController,
                      'Color name',
                    ),
                    const SizedBox(height: 12),
                    _dialogField(
                      quantityController,
                      'Quantity',
                      isNumber: true,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .where((item) => item != 'All')
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          updateDialog(() {
                            category = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    nameController.dispose();
                    brandController.dispose();
                    colorController.dispose();
                    quantityController.dispose();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final quantity =
                    int.tryParse(quantityController.text.trim());

                    if (name.isEmpty ||
                        quantity == null ||
                        quantity < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Enter a yarn name and valid quantity.',
                          ),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _yarns.insert(
                        0,
                        YarnItem(
                          name: name,
                          brand: brandController.text.trim().isEmpty
                              ? 'Unknown brand'
                              : brandController.text.trim(),
                          colorName:
                          colorController.text.trim().isEmpty
                              ? 'Not specified'
                              : colorController.text.trim(),
                          quantity: quantity,
                          unit: 'balls',
                          category: category,
                          color: AppColors.softPink,
                        ),
                      );

                      _selectedCategory = 'All';
                    });

                    Navigator.pop(dialogContext);
                    nameController.dispose();
                    brandController.dispose();
                    colorController.dispose();
                    quantityController.dispose();
                  },
                  child: const Text('Add Yarn'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _dialogField(
      TextEditingController controller,
      String label, {
        bool isNumber = false,
      }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class YarnItem {
  final String name;
  final String brand;
  final String colorName;
  int quantity;
  final String unit;
  final String category;
  final Color color;

  YarnItem({
    required this.name,
    required this.brand,
    required this.colorName,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.color,
  });
}
