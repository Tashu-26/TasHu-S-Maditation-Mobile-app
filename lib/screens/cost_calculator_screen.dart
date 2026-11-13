
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CostCalculatorScreen extends StatefulWidget {
  const CostCalculatorScreen({super.key});

  @override
  State<CostCalculatorScreen> createState() =>
      _CostCalculatorScreenState();
}

class _CostCalculatorScreenState
    extends State<CostCalculatorScreen> {
  final TextEditingController _yarnController =
  TextEditingController();

  final TextEditingController _hookController =
  TextEditingController();

  final TextEditingController _accessoriesController =
  TextEditingController();

  final TextEditingController _otherController =
  TextEditingController();

  final TextEditingController _quantityController =
  TextEditingController(text: '1');

  double _readAmount(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }

  int get _quantity {
    final value = int.tryParse(_quantityController.text.trim()) ?? 1;
    return value < 1 ? 1 : value;
  }

  double get _yarnCost => _readAmount(_yarnController);
  double get _hookCost => _readAmount(_hookController);
  double get _accessoriesCost =>
      _readAmount(_accessoriesController);
  double get _otherCost => _readAmount(_otherController);

  double get _totalCost =>
      _yarnCost + _hookCost + _accessoriesCost + _otherCost;

  double get _costPerItem => _totalCost / _quantity;

  @override
  void dispose() {
    _yarnController.dispose();
    _hookController.dispose();
    _accessoriesController.dispose();
    _otherController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _clearCalculator() {
    _yarnController.clear();
    _hookController.clear();
    _accessoriesController.clear();
    _otherController.clear();
    _quantityController.text = '1';

    setState(() {});
  }

  Widget _buildCostField({
    required String title,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 19, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.darkBrown,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: hint,
              prefixText: '৳ ',
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
          Text(
            '৳ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.darkBrown,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cost Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: _clearCalculator,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reset'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 35,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Know Your Project Cost',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Enter your material expenses and calculate '
                        'the total cost of your handmade creation.',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Material Expenses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),

            const SizedBox(height: 16),

            _buildCostField(
              title: 'Yarn Cost',
              hint: 'Enter yarn expense',
              icon: Icons.circle_outlined,
              controller: _yarnController,
            ),

            _buildCostField(
              title: 'Hook & Tools Cost',
              hint: 'Enter hook or tool expense',
              icon: Icons.handyman_outlined,
              controller: _hookController,
            ),

            _buildCostField(
              title: 'Accessories Cost',
              hint: 'Buttons, zippers, keyrings, etc.',
              icon: Icons.shopping_bag_outlined,
              controller: _accessoriesController,
            ),

            _buildCostField(
              title: 'Other Expenses',
              hint: 'Packaging or other expenses',
              icon: Icons.more_horiz,
              controller: _otherController,
            ),

            const SizedBox(height: 8),

            const Text(
              'Number of Items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBrown,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Enter quantity',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cost Summary',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildSummaryRow('Yarn', _yarnCost),
                  _buildSummaryRow('Hooks & Tools', _hookCost),
                  _buildSummaryRow('Accessories', _accessoriesCost),
                  _buildSummaryRow('Other Expenses', _otherCost),

                  const Divider(
                    height: 25,
                    color: AppColors.border,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Cost',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      Text(
                        '৳ ${_totalCost.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Cost Per Item',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '৳ ${_costPerItem.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tip: Remember to include all your material expenses '
                  'for a more accurate project cost.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
