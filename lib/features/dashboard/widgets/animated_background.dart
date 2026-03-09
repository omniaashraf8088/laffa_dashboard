import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Floating orbs animated background for a creative dashboard feel.
class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_FloatingOrb> _orbs = [];

  @override
  void initState() {
    super.initState();
    final rng = Random(42);
    for (int i = 0; i < 6; i++) {
      _orbs.add(
        _FloatingOrb(
          x: rng.nextDouble(),
          y: rng.nextDouble(),
          radius: 80 + rng.nextDouble() * 160,
          speedX: (rng.nextDouble() - 0.5) * 0.003,
          speedY: (rng.nextDouble() - 0.5) * 0.003,
          color: [
            AppColors.purple,
            AppColors.purpleLight,
            AppColors.cyan,
          ][i % 3],
        ),
      );
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _controller.addListener(() {
      for (final orb in _orbs) {
        orb.x += orb.speedX;
        orb.y += orb.speedY;
        if (orb.x < -0.2 || orb.x > 1.2) orb.speedX *= -1;
        if (orb.y < -0.2 || orb.y > 1.2) orb.speedY *= -1;
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
    return Stack(
      fit: StackFit.expand,
      children: [
        // Animated gradient orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _OrbsPainter(_orbs),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _FloatingOrb {
  double x, y, radius, speedX, speedY;
  Color color;
  _FloatingOrb({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.color,
  });
}

class _OrbsPainter extends CustomPainter {
  final List<_FloatingOrb> orbs;
  _OrbsPainter(this.orbs);

  @override
  void paint(Canvas canvas, Size size) {
    for (final orb in orbs) {
      final paint = Paint()
        ..shader =
            RadialGradient(
              colors: [orb.color.withAlpha(25), orb.color.withAlpha(0)],
            ).createShader(
              Rect.fromCircle(
                center: Offset(orb.x * size.width, orb.y * size.height),
                radius: orb.radius,
              ),
            );
      canvas.drawCircle(
        Offset(orb.x * size.width, orb.y * size.height),
        orb.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Glassmorphism container with frosted glass effect.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final double opacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((opacity * 255).toInt()),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.overlayWhiteSubtle, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Neon glow box decoration helper.
class NeonDecoration {
  static BoxDecoration glow({
    required Color color,
    double borderRadius = 20,
    double glowIntensity = 0.4,
    double blurRadius = 30,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha((glowIntensity * 255).toInt()),
          blurRadius: blurRadius,
          spreadRadius: -4,
        ),
        BoxShadow(
          color: color.withAlpha((glowIntensity * 0.3 * 255).toInt()),
          blurRadius: blurRadius * 2,
          spreadRadius: -8,
        ),
      ],
    );
  }
}
