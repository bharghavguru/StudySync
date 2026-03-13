import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.userName = 'Alex',
  });

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    _HomePage(),
    _PlaceholderPage(title: 'Timetable'),
    _PlaceholderPage(title: 'Attendance'),
    _PlaceholderPage(title: 'Exams'),
    _PlaceholderPage(title: 'Profile'),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF0F172A),
        toolbarHeight: 96,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Good Morning, ${widget.userName}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Placeholder for settings
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings not implemented yet')),
                    );
                  },
                  icon: const Icon(Icons.settings_outlined),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text(
              _formattedDate(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Exams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    final weekday = _weekdayName(now.weekday);
    final month = _monthName(now.month);
    final day = now.day;

    // Suffix logic (st, nd, rd, th)
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else if (day % 10 == 1) {
      suffix = 'st';
    } else if (day % 10 == 2) {
      suffix = 'nd';
    } else if (day % 10 == 3) {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    return '$weekday, $month $day$suffix';
  }

  String _weekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
      default:
        return 'Sunday';
    }
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final List<_RequiredItem> _requiredToday = [
    _RequiredItem(title: 'Math Notebook (Vol. 2)', completed: true),
    _RequiredItem(title: 'Physics Lab File', completed: false),
    _RequiredItem(title: 'Scientific Calculator', completed: false),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _TodayClassesCard(
            classes: const [
              _ClassSession(
                title: 'Organic Chemistry',
                time: '08:30 AM - 10:00 AM',
                location: 'Lab 2, West Wing',
                status: _ClassStatus.done,
              ),
              _ClassSession(
                title: 'Advanced Mathematics',
                time: '10:30 AM - 12:00 PM',
                location: 'Room 402, Science Block',
                status: _ClassStatus.ongoing,
              ),
              _ClassSession(
                title: 'English Literature',
                time: '01:30 PM - 03:00 PM',
                location: 'Room 105, Arts Block',
                status: _ClassStatus.upcoming,
              ),
            ],
            onScheduleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Schedule tapped')),
              );
            },
          ),
          const SizedBox(height: 20),
          _RequiredTodayCard(
            items: _requiredToday,
            onChanged: (index, value) {
              setState(() {
                _requiredToday[index] = _requiredToday[index].copyWith(completed: value);
              });
            },
          ),
          const SizedBox(height: 20),
          _AttendanceCard(primary: primary),
          const SizedBox(height: 20),
          _NextExamCard(primary: primary),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TodayClassesCard extends StatelessWidget {
  const _TodayClassesCard({
    required this.classes,
    required this.onScheduleTap,
  });

  final List<_ClassSession> classes;
  final VoidCallback onScheduleTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.06 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Today's Classes",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                onPressed: onScheduleTap,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  backgroundColor: primary.withAlpha((0.12 * 255).round()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  'SCHEDULE',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: primary,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: classes.asMap().entries.map((entry) {
              final index = entry.key;
              final session = entry.value;
              return _TodayClassRow(
                session: session,
                isLast: index == classes.length - 1,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

enum _ClassStatus { done, ongoing, upcoming }

class _ClassSession {
  const _ClassSession({
    required this.title,
    required this.time,
    required this.location,
    required this.status,
  });

  final String title;
  final String time;
  final String location;
  final _ClassStatus status;
}

class _TodayClassRow extends StatelessWidget {
  const _TodayClassRow({
    required this.session,
    required this.isLast,
  });

  final _ClassSession session;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    Color dotColor;
    IconData icon;
    Color titleColor;

    switch (session.status) {
      case _ClassStatus.done:
        dotColor = Colors.grey.shade300;
        icon = Icons.check;
        titleColor = Colors.grey;
        break;
      case _ClassStatus.ongoing:
        dotColor = primary;
        icon = Icons.play_circle_fill;
        titleColor = Colors.black;
        break;
      case _ClassStatus.upcoming:
        dotColor = Colors.orange.shade300;
        icon = Icons.schedule;
        titleColor = Colors.black;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 14,
                    color: session.status == _ClassStatus.done ? Colors.white : Colors.white,
                  ),
                ),
                if (!isLast)
                  SizedBox(
                    height: 40,
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        session.title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: titleColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: session.status == _ClassStatus.done
                            ? Colors.grey.shade200
                            : session.status == _ClassStatus.ongoing
                                ? primary.withAlpha((0.12 * 255).round())
                                : Colors.orange.withAlpha((0.16 * 255).round()),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        session.status == _ClassStatus.done
                            ? 'DONE'
                            : session.status == _ClassStatus.ongoing
                                ? 'ONGOING'
                                : 'UPCOMING',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: session.status == _ClassStatus.done
                              ? Colors.grey.shade700
                              : session.status == _ClassStatus.ongoing
                                  ? primary
                                  : Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      session.time,
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        session.location,
                        style:
                            theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RequiredTodayCard extends StatelessWidget {
  const _RequiredTodayCard({
    required this.items,
    required this.onChanged,
  });

  final List<_RequiredItem> items;
  final void Function(int index, bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.06 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required Today',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (entry) => Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: entry.value.completed,
                          onChanged: (val) {
                            if (val != null) {
                              onChanged(entry.key, val);
                            }
                          },
                        ),
                        Expanded(
                          child: Text(
                            entry.value.title,
                            style: TextStyle(
                              fontSize: 16,
                              color: entry.value.completed
                                  ? Colors.grey
                                  : Colors.grey.shade800,
                              decoration: entry.value.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (entry.key != items.length - 1) const Divider(),
                  ],
                ),
              ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Manage Items clicked')),
              );
            },
            child: Text(
              'Manage Items',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    const percentage = 0.9;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.06 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(
                      value: percentage,
                      strokeWidth: 12,
                      color: primary,
                      backgroundColor: primary.withAlpha((0.2 * 255).round()),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(percentage * 100).round()}%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'OVERALL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  "You're 15% above the 75% requirement. Keep it up!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View Detailed Stats clicked')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'View Detailed Stats',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextExamCard extends StatelessWidget {
  const _NextExamCard({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    final examDate = DateTime.now().add(const Duration(days: 19, hours: 14, minutes: 32));
    final diff = examDate.difference(DateTime.now());

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            primary.withAlpha((0.95 * 255).round()),
            primary.withAlpha((0.8 * 255).round()),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withAlpha((0.25 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                '${_monthName(examDate.month)} ${examDate.day}, ${examDate.year}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Applied Physics II',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CountdownTile(value: days, label: 'DAYS'),
              _CountdownTile(value: hours, label: 'HOURS'),
              _CountdownTile(value: minutes, label: 'MINS'),
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

class _CountdownTile extends StatelessWidget {
  const _CountdownTile({
    required this.value,
    required this.label,
  });

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title (Coming Soon)',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _RequiredItem {
  final String title;
  final bool completed;

  _RequiredItem({
    required this.title,
    required this.completed,
  });

  _RequiredItem copyWith({String? title, bool? completed}) {
    return _RequiredItem(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
