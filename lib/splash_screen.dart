import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF615EEA), // Lighter top color
              Color(0xFF4A46D4), // Darker bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 4),
            // Logo and Title Area
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Outer circle background
                Container(
                  padding: const EdgeInsets.all(36),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(25), // 0.1 opacity
                    border: Border.all(
                      color: Colors.white.withAlpha(51), // 0.2 opacity
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                // Sync badge
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: RotationTransition(
                      turns: _controller,
                      child: const Icon(
                        Icons.sync,
                        size: 20,
                        color: Color(0xFF4A46D4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'StudySync',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your Academic Command Center',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white.withAlpha(229), // 0.9 opacity
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(flex: 3),
            
            // Bottom Loading Area
            RotationTransition(
              turns: _controller,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                // To create the 'arc' look from the image, we could use a CircularProgressIndicator
                // But the image shows a white ring with a gap, let's use a standard CircularProgressIndicator inside
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                  value: 0.8, // Leaving a small gap to look like the image
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SYNCHRONIZING',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withAlpha(178), // 0.7 opacity
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(height: 16),
            // Fake Progress Bar
            Container(
              width: 180,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51), // 0.2 opacity
                borderRadius: BorderRadius.circular(2),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 60, // Represents about 33% progress
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
