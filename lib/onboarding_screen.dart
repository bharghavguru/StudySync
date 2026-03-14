import 'dart:ui';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _onSkip() {
    _navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _onSkip,
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage(
                    illustration: _buildIllustration1(),
                    title: 'Plan Your Week\nSmarter',
                    description:
                        'Organize your classes, labs, and study\nsessions in one beautiful weekly timetable.',
                  ),
                  _buildPage(
                    illustration: _buildIllustrationPlaceholder(Icons.check_circle_outline),
                    title: 'Track Attendance\nAutomatically',
                    description:
                        'Keep up with your absence limits and never\nmiss an important lecture again.',
                  ),
                  _buildPage(
                    illustration: _buildIllustrationPlaceholder(Icons.notifications_active_outlined),
                    title: 'Stay Notified\nAlways',
                    description:
                        'Get smart reminders for assignments, exams,\nand upcoming classes right on time.',
                  ),
                ],
              ),
            ),
            
            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildDotIndicator(index)),
            ),
            
            const SizedBox(height: 32),
            
            // Next/Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A55EA), // Primary Purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == 2 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (_currentPage < 2) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5A55EA) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildPage({
    required Widget illustration,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: illustration,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.2,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Color(0xFF475569),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  // First Illustration based strictly on user image
  Widget _buildIllustration1() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE8FE), // Soft purple outer container
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Container(
          width: 200,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF615EEA).withAlpha(10), // Small drop shadow
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top placeholder block
                Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD5D2FB), // Top purple fill
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 12),
                // Second placeholder block
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 28,
                    width: 120, // Shorter than top block
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9), // Very light gray/blue fill
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Main calendar content block with dashed border
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomPaint(
                      painter: DashedRectPainter(
                        color: const Color(0xFFA5A3F4), // Light purple dashe border
                        strokeWidth: 2,
                        gap: 6,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.calendar_month,
                          color: Color(0xFF5A55EA), // Primary purple calendar icon
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Generic illustration placeholder for page 2 and 3
  Widget _buildIllustrationPlaceholder(IconData icon) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE8FE), // Soft purple outer container
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF615EEA).withAlpha(10), // Small drop shadow
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 64,
            color: const Color(0xFF5A55EA),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for dashed border rectangle
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ));

    final Path dashPath = _dashPath(path, dashArray: CircularIntervalList<double>([8.0, gap]));
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Path _dashPath(Path source, {required CircularIntervalList<double> dashArray}) {
  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = 0.0;
    bool draw = true;
    while (distance < metric.length) {
      final double len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }
  return dest;
}

class CircularIntervalList<T> {
  CircularIntervalList(this._vals);
  final List<T> _vals;
  int _idx = 0;
  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
