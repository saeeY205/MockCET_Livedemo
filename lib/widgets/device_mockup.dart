import 'package:flutter/material.dart';

class DeviceMockup extends StatelessWidget {
  final Widget child;
  const DeviceMockup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 500;

    if (!isDesktop) return child;

    return Scaffold(
      backgroundColor: const Color(0xFF1A237E).withValues(alpha: 0.1),
      body: Center(
        child: Container(
          width: 340,
          height: 720,
          margin: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFF333333), width: 8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Stack(
            children: [
              // The App Content
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: child,
              ),
              // Dynamic Island
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
