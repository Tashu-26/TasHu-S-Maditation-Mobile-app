
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class TutorialSimplifierScreen extends StatefulWidget {
  const TutorialSimplifierScreen({super.key});

  @override
  State<TutorialSimplifierScreen> createState() =>
      _TutorialSimplifierScreenState();
}

class _TutorialSimplifierScreenState
    extends State<TutorialSimplifierScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _instructionsController =
  TextEditingController();

  bool _showResult = false;
  bool _saved = false;
  String? _errorMessage;

  final List<String> _simpleSteps = [
    'Start by making a magic ring.',
    'Chain 3 stitches. This counts as your first double crochet.',
    'Make 2 double crochet stitches into the ring.',
    'Chain 2 stitches to create a corner.',
    'Repeat the pattern until you have four groups.',
    'Join the round using a slip stitch.',
  ];

  @override
  void dispose() {
    _urlController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _simplifyTutorial() {
    final url = _urlController.text.trim();
    final instructions = _instructionsController.text.trim();

    setState(() {
      _errorMessage = null;
      _saved = false;
    });

    if (url.isEmpty && instructions.isEmpty) {
      setState(() {
        _errorMessage =
        'Please enter a tutorial link or paste the instructions.';
        _showResult = false;
      });
      return;
    }

    if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath != true) {
      setState(() {
        _errorMessage = 'Please enter a valid tutorial link.';
        _showResult = false;
      });
      return;
    }

    if (instructions.isEmpty) {
      setState(() {
        _errorMessage =
        'We cannot read tutorial links automatically yet. '
            'Please paste the written instructions below.';
        _showResult = false;
      });
      return;
    }

    setState(() {
      _showResult = true;
    });
  }

  void _copyInstructions() {
    final text = _simpleSteps
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');

    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Instructions copied!'),
      ),
    );
  }

  void _saveInstructions() {
    setState(() {
      _saved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tutorial saved for this session!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Tutorial Simplifier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildInputSection(),
              const SizedBox(height: 20),
              _buildSimplifyButton(),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                _buildErrorMessage(),
              ],
              if (_showResult) ...[
                const SizedBox(height: 28),
                _buildResultSection(),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Make crochet tutorials easier.',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Confusing crochet instructions? Paste the written '
                'steps and explore a beginner-friendly version.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tutorial URL',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _urlController,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            hintText: 'https://example.com/crochet-tutorial',
            prefixIcon: const Icon(
              Icons.link,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Paste tutorial instructions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _instructionsController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText:
            'Example: Ch 3, 2 dc in ring, ch 2, repeat...',
            alignLabelWithHint: true,
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tip: Paste the written instructions from a video '
              'or website for the best result.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildSimplifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _simplifyTutorial,
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Simplify Tutorial'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(
                color: AppColors.darkBrown,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Simplified Instructions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
            Icon(
              Icons.check_circle,
              color: AppColors.sageGreen,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Beginner-friendly example result',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 16),
        _buildStepsCard(),
        const SizedBox(height: 16),
        _buildAbbreviationsCard(),
        const SizedBox(height: 16),
        _buildDifficultPartsCard(),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _copyInstructions,
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _saveInstructions,
                icon: Icon(
                  _saved ? Icons.bookmark : Icons.bookmark_outline,
                ),
                label: Text(_saved ? 'Saved' : 'Save to Notes'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'This is sample output for the prototype. '
              'AI-based instruction simplification will be added later.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStepsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Easy steps',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 16),
          ..._simpleSteps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.cream,
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        color: AppColors.darkBrown,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAbbreviationsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Crochet Abbreviations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: 12),
          _AbbreviationRow(shortForm: 'ch', meaning: 'Chain'),
          _AbbreviationRow(shortForm: 'dc', meaning: 'Double Crochet'),
          _AbbreviationRow(shortForm: 'sl st', meaning: 'Slip Stitch'),
          _AbbreviationRow(shortForm: 'yo', meaning: 'Yarn Over'),
        ],
      ),
    );
  }

  Widget _buildDifficultPartsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                'Difficult parts explained',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.darkBrown,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Corner chain-2 spaces',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'When the pattern says to work into a chain-2 space, '
                'put your hook into the open gap between stitches, '
                'not into the top of an individual stitch.',
            style: TextStyle(
              color: AppColors.secondaryText,
              height: 1.5,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _AbbreviationRow extends StatelessWidget {
  final String shortForm;
  final String meaning;

  const _AbbreviationRow({
    required this.shortForm,
    required this.meaning,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 65,
            child: Text(
              shortForm,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              meaning,
              style: const TextStyle(
                color: AppColors.darkBrown,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
