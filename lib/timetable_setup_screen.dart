import 'package:flutter/material.dart';

import 'campus_setup_screen.dart';

class TimetableSetupScreen extends StatefulWidget {
  const TimetableSetupScreen({
    super.key,
    this.userName = 'Alex',
    this.currentStep = 4,
    this.totalSteps = 6,
  });

  final String userName;
  final int currentStep;
  final int totalSteps;

  @override
  State<TimetableSetupScreen> createState() => _TimetableSetupScreenState();
}

class _TimetableSetupScreenState extends State<TimetableSetupScreen> {
  final List<String> _baseDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  bool _includeSaturday = false;
  int _selectedDayIndex = 0;

  List<String> get _days =>
      _includeSaturday ? _baseDays : _baseDays.take(5).toList();

  void _onSelectDay(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  void _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CampusSetupScreen(
          userName: widget.userName,
          currentStep: widget.currentStep + 1,
          totalSteps: widget.totalSteps,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showEditClassDialog(String title) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: const Text('This is a placeholder for editing the class details.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddClassDialog(String time) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Class'),
        content: Text('Add a class for $time (placeholder).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Timetable Setup',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Onboarding Progress',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: widget.totalSteps > 0
                              ? widget.currentStep / widget.totalSteps
                              : 0,
                          minHeight: 8,
                          color: const Color(0xFF4754FF),
                          backgroundColor: const Color(0xFFD9DBFF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${widget.currentStep}/${widget.totalSteps}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Building your weekly class schedule',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Include Saturday',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Switch(
                      value: _includeSaturday,
                      activeThumbColor: const Color(0xFF4754FF),
                      onChanged: (value) {
                        setState(() {
                          _includeSaturday = value;
                          if (_selectedDayIndex >= _days.length) {
                            _selectedDayIndex = _days.length - 1;
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _days.length,
                    (index) => GestureDetector(
                      onTap: () => _onSelectDay(index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _days[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _selectedDayIndex == index
                                  ? const Color(0xFF4754FF)
                                  : const Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: _selectedDayIndex == index
                                  ? const Color(0xFF4754FF)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '${_fullDayName(_selectedDayIndex)} Classes',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 16),
                _buildClassCard(
                  title: 'Advanced Mathematics',
                  time: '08:00 AM - 09:30 AM',
                  location: 'Room 402',
                  onEdit: () => _showEditClassDialog('Advanced Mathematics'),
                ),
                const SizedBox(height: 16),
                _buildClassCard(
                  title: 'English Literature',
                  time: '10:00 AM - 11:30 AM',
                  location: 'Online',
                  onEdit: () => _showEditClassDialog('English Literature'),
                ),
                const SizedBox(height: 16),
                _buildEmptySlotCard(
                  time: '01:00 PM - 02:30 PM',
                  onAdd: () => _showAddClassDialog('01:00 PM - 02:30 PM'),
                ),
                const SizedBox(height: 16),
                _buildLunchBreakRow(),
                const SizedBox(height: 16),
                _buildEmptySlotCard(
                  time: '03:00 PM - 04:30 PM',
                  onAdd: () => _showAddClassDialog('03:00 PM - 04:30 PM'),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4754FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Next: Campus Setup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'You can always edit this later in Settings.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _fullDayName(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      default:
        return '';
    }
  }

  Widget _buildClassCard({
    required String title,
    required String time,
    required String location,
    required VoidCallback onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E9FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.schedule,
                color: Color(0xFF4754FF),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$time • $location',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onEdit,
            child: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF4754FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySlotCard({
    required String time,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD9E1FF), width: 1.5),
        color: const Color(0xFFF7F9FF),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E9FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Color(0xFF4754FF),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'No subject added',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onAdd,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4754FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              elevation: 0,
            ),
            child: const Text(
              'Add Subject',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLunchBreakRow() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.restaurant_menu,
              color: Color(0xFF94A3B8),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Lunch Break • 12:00 PM',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
            ),
          ),
        ),
      ],
    );
  }
}
