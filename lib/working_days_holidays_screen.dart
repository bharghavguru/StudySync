import 'package:flutter/material.dart';
import 'location_permission_screen.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Model for a holiday
// ──────────────────────────────────────────────────────────────────────────────
class _Holiday {
  _Holiday({required this.name, required this.date});
  final String name;
  final DateTime date;

  String get dateLabel {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Step 5: Working Days & Holidays
// ──────────────────────────────────────────────────────────────────────────────
class WorkingDaysHolidaysScreen extends StatefulWidget {
  const WorkingDaysHolidaysScreen({super.key, required this.userName});
  final String userName;

  @override
  State<WorkingDaysHolidaysScreen> createState() =>
      _WorkingDaysHolidaysScreenState();
}

class _WorkingDaysHolidaysScreenState
    extends State<WorkingDaysHolidaysScreen> {
  static const int _totalSteps = 7;
  static const int _currentStep = 5;

  // Working days – Mon–Fri selected by default
  final List<String> _allDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  final Set<String> _selectedWorkingDays = {
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
  };

  // Holidays
  final List<_Holiday> _holidays = [
    _Holiday(name: 'Independence Day', date: DateTime(2024, 7, 4)),
    _Holiday(name: 'Labor Day', date: DateTime(2024, 9, 2)),
  ];

  // Quick-add fields
  final TextEditingController _holidayNameController = TextEditingController();
  DateTime? _selectedHolidayDate;

  @override
  void dispose() {
    _holidayNameController.dispose();
    super.dispose();
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedWorkingDays.contains(day)) {
        _selectedWorkingDays.remove(day);
      } else {
        _selectedWorkingDays.add(day);
      }
    });
  }

  void _removeHoliday(int index) {
    setState(() => _holidays.removeAt(index));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3730D4),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedHolidayDate = picked);
    }
  }

  void _addHoliday() {
    final name = _holidayNameController.text.trim();
    if (name.isEmpty || _selectedHolidayDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a holiday name and select a date')),
      );
      return;
    }
    setState(() {
      _holidays.add(_Holiday(name: name, date: _selectedHolidayDate!));
      _holidayNameController.clear();
      _selectedHolidayDate = null;
    });
  }

  void _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocationPermissionScreen(userName: widget.userName),
      ),
    );
  }

  void _onBack() => Navigator.of(context).maybePop();

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

  // ── AppBar ─────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF4F46E5)),
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

  Widget _buildStepHeader() {
    final progress = _currentStep / _totalSteps;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STEP 5 OF 7',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Working Days &\nHolidays',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    height: 1.2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
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
        ],
      ),
    );
  }

  // ── Body ───────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header removed from here to fix negative margin assertion
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withAlpha(15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_month,
                    color: Color(0xFF4F46E5), size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'Select Working Days',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose the days of the week when classes or\nstudy sessions are active.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Day grid – 2 columns
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.2,
            ),
            itemCount: _allDays.length,
            itemBuilder: (context, i) {
              final day = _allDays[i];
              final isSelected = _selectedWorkingDays.contains(day);
              return GestureDetector(
                onTap: () => _toggleDay(day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4F46E5)
                          : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? const Color(0xFF4F46E5)
                            : const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 28),

          // ── Holiday Calendar ───────────────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withAlpha(15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.event_available,
                    color: Color(0xFF4F46E5), size: 20),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Holiday Calendar',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Scroll to quick add section
                },
                child: const Text(
                  '+ Add Holiday',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Holiday cards
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: List.generate(_holidays.length, (i) {
                final holiday = _holidays[i];
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F1FC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.flag_outlined,
                            color: Color(0xFF4F46E5), size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              holiday.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              holiday.dateLabel,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeHoliday(i),
                        icon: const Icon(Icons.delete_outline,
                            color: Color(0xFFCBD5E1), size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              })
                ..add(const SizedBox(height: 10)),
            ),
          ),

          const SizedBox(height: 20),

          // ── Quick Add Holiday ──────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QUICK ADD HOLIDAY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 12),
                // Holiday Name
                TextField(
                  controller: _holidayNameController,
                  decoration: InputDecoration(
                    hintText: 'Holiday Name',
                    hintStyle: const TextStyle(
                        color: Color(0xFFADB5C8), fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Date picker
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedHolidayDate == null
                                ? 'mm/dd/yyyy'
                                : '${_selectedHolidayDate!.month.toString().padLeft(2, '0')}/${_selectedHolidayDate!.day.toString().padLeft(2, '0')}/${_selectedHolidayDate!.year}',
                            style: TextStyle(
                              fontSize: 14,
                              color: _selectedHolidayDate == null
                                  ? const Color(0xFFADB5C8)
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const Icon(Icons.calendar_today_outlined,
                            size: 18, color: Color(0xFFADB5C8)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Add button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _addHoliday,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3730D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom buttons ─────────────────────────────────────────────────────────
  Widget _buildBottom() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      child: Row(
        children: [
          // Back button
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: _onBack,
              icon: const Icon(Icons.chevron_left,
                  color: Color(0xFF0F172A), size: 20),
              label: const Text(
                'Back',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Next Step button
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _onNext,
                label: const Text(
                  'Next Step',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.chevron_right,
                    color: Colors.white, size: 20),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3730D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
