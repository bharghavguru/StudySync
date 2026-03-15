import 'package:flutter/material.dart';
import 'academic_information_screen.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Step 2: Institution & Department
// ──────────────────────────────────────────────────────────────────────────────
class InstitutionDepartmentScreen extends StatefulWidget {
  const InstitutionDepartmentScreen({super.key, required this.userName});
  final String userName;

  @override
  State<InstitutionDepartmentScreen> createState() =>
      _InstitutionDepartmentScreenState();
}

class _InstitutionDepartmentScreenState
    extends State<InstitutionDepartmentScreen> {
  static const int _totalSteps = 7;
  static const int _currentStep = 2;

  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  static const List<String> _quickTags = [
    'Engineering',
    'Arts & Design',
    'Business',
    'Science',
    'Medicine',
    'Law',
    'Education',
  ];

  String? _selectedTag;

  @override
  void dispose() {
    _institutionController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  void _onTagTap(String tag) {
    setState(() {
      _selectedTag = _selectedTag == tag ? null : tag;
      _departmentController.text = _selectedTag ?? '';
    });
  }

  void _onContinue() {
    // Navigate to Step 3: Academic Information
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AcademicInformationScreen(userName: widget.userName),
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildStepHeader(),
          Expanded(child: _buildBody()),
          _buildBottom(),
        ],
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
        onPressed: _onBack,
      ),
      title: const Text(
        'Setup Wizard',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  // ── Step header ───────────────────────────────────────────────────────────
  Widget _buildStepHeader() {
    final progress = _currentStep / _totalSteps;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile Setup',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '$_currentStep of $_totalSteps',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 6,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  height: 6,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3730D4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 14),
          // Section label
          const Text(
            'INSTITUTION & DEPARTMENT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              color: Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }

  // ── Scrollable body ───────────────────────────────────────────────────────
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Where do you study?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please provide your academic details to help\nus personalize your study groups and connect\nyou with peers.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),

          // Institution Name field
          const Text(
            'Institution Name',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _institutionController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Search your university or school',
              hintStyle: const TextStyle(
                color: Color(0xFFADB5C8),
                fontSize: 14,
              ),
              suffixIcon: const Icon(Icons.search, color: Color(0xFFADB5C8)),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF4F46E5),
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Start typing to see suggestions',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFADB5C8),
            ),
          ),

          const SizedBox(height: 24),

          // Department or Major field
          const Text(
            'Department or Major',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _departmentController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'e.g. Computer Science, Medicine',
              hintStyle: const TextStyle(
                color: Color(0xFFADB5C8),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF4F46E5),
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick-select department chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _quickTags
                .map((tag) => _buildChip(tag))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedTag == label;
    return GestureDetector(
      onTap: () => _onTagTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5).withAlpha(15) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFDDE3EE),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }

  // ── Bottom buttons ──────────────────────────────────────────────────────────
  Widget _buildBottom() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3730D4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: _onBack,
            child: const Text(
              'Back to previous step',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3730D4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
