import 'package:flutter/material.dart';
import 'summary_confirm_screen.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Step 6: Location Permission
// ──────────────────────────────────────────────────────────────────────────────
class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key, required this.userName});
  final String userName;

  static const int _totalSteps = 7;
  static const int _currentStep = 6;

  void _onAllow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SummaryConfirmScreen(userName: userName),
      ),
    );
  }

  void _onMaybeLater(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SummaryConfirmScreen(userName: userName),
      ),
    );
  }

  void _onBack(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final progress = _currentStep / _totalSteps;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => _onBack(context),
        ),
        title: const Text(
          'StudySync Setup',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Step header ──────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Step 6: Location Permission',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      '$_currentStep/$_totalSteps',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
          ),

          // ── Scrollable content ───────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Map illustration
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://maps.googleapis.com/maps/api/staticmap?center=Palo+Alto,CA&zoom=12&size=600x400&maptype=roadmap&key=DEMO_KEY',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) {
                            // Fallback illustrated map when no API key
                            return _MapIllustration();
                          },
                        ),
                        // Location pin overlay
                        const Center(
                          child: _LocationPin(),
                        ),
                      ],
                    ),
                  ),

                  // ── Text + Feature cards ──────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Enable Location\nTracking',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'StudySync uses your location to automatically record your attendance when you enter campus boundaries. This ensures your participation is tracked accurately without manual check-ins.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Privacy First card
                        _FeatureCard(
                          icon: Icons.verified_user_outlined,
                          iconColor: const Color(0xFF4F46E5),
                          title: 'Privacy First',
                          subtitle:
                              'We only track your location within predefined campus zones.',
                        ),
                        const SizedBox(height: 12),

                        // Battery Optimized card
                        _FeatureCard(
                          icon: Icons.bolt_outlined,
                          iconColor: const Color(0xFF4F46E5),
                          title: 'Battery Optimized',
                          subtitle:
                              'Uses geofencing technology to minimize battery impact.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom buttons ───────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () => _onAllow(context),
                    icon: const Icon(Icons.near_me,
                        color: Colors.white, size: 20),
                    label: const Text(
                      'Allow Access',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3730D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => _onMaybeLater(context),
                  child: const Text(
                    'Maybe later',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
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
}

// ── Map illustration fallback ──────────────────────────────────────────────
class _MapIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD6EAF8),
      child: CustomPaint(
        painter: _MapPainter(),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final minorRoadPaint = Paint()
      ..color = Colors.white.withAlpha(180)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final greenPaint = Paint()
      ..color = const Color(0xFFAED6A0)
      ..style = PaintingStyle.fill;

    // Park blobs
    canvas.drawOval(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.1,
            size.width * 0.18, size.height * 0.22),
        greenPaint);
    canvas.drawOval(
        Rect.fromLTWH(size.width * 0.7, size.height * 0.05,
            size.width * 0.2, size.height * 0.18),
        greenPaint);
    canvas.drawOval(
        Rect.fromLTWH(size.width * 0.6, size.height * 0.65,
            size.width * 0.25, size.height * 0.25),
        greenPaint);

    // Horizontal roads
    for (int i = 1; i <= 5; i++) {
      final y = size.height * i / 6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y),
          i.isEven ? roadPaint : minorRoadPaint);
    }
    // Vertical roads
    for (int i = 1; i <= 4; i++) {
      final x = size.width * i / 5;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height),
          i.isEven ? roadPaint : minorRoadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Location pin widget ────────────────────────────────────────────────────
class _LocationPin extends StatelessWidget {
  const _LocationPin();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF3730D4),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3730D4).withAlpha(100),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(Icons.location_on, color: Colors.white, size: 28),
        ),
        // Pin tail
        Container(
          width: 3,
          height: 10,
          color: const Color(0xFF3730D4),
        ),
      ],
    );
  }
}

// ── Feature card ───────────────────────────────────────────────────────────
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
