import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class SunMoonWidget extends StatefulWidget {
  const SunMoonWidget({this.size = 200, super.key});

  final double size;

  @override
  State<SunMoonWidget> createState() => _SunMoonWidgetState();
}

class _SunMoonWidgetState extends State<SunMoonWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  bool get _isMorning {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 17;
  }

  @override
  void initState() {
    super.initState();

    // Rotation for sun rays (10 seconds per rotation - faster)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Pulse animation (2.5 seconds cycle - more dynamic)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Floating animation for moon (3 seconds, gentle up/down)
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: _isMorning ? _buildSun() : _buildMoon(),
        ),
      ),
    );
  }

  Widget _buildSun() {
    return AnimatedBuilder(
      key: const ValueKey('sun'),
      animation: Listenable.merge([_rotationController, _pulseAnimation]),
      builder: (context, _) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _SunPainter(
              rotationAngle: _rotationController.value * 2 * math.pi,
              pulseValue: _pulseAnimation.value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoon() {
    return AnimatedBuilder(
      key: const ValueKey('moon'),
      animation: Listenable.merge([
        _pulseAnimation,
        _floatAnimation,
        _rotationController,
      ]),
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Transform.rotate(
            angle: _rotationController.value * 0.1, // Subtle rotation
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _MoonPainter(
                glowOpacity: _pulseAnimation.value,
                starPhase: _rotationController.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SunPainter extends CustomPainter {
  _SunPainter({
    required this.rotationAngle,
    required this.pulseValue,
  });

  final double rotationAngle;
  final double pulseValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final sunRadius = size.width * 0.18;

    // Large outer glow
    final outerGlowPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.08 * pulseValue)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawCircle(center, sunRadius * 3, outerGlowPaint);

    // Medium glow
    final midGlowPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.15 * pulseValue)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);
    canvas.drawCircle(center, sunRadius * 2, midGlowPaint);

    // Inner glow
    final innerGlowPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(center, sunRadius * 1.4, innerGlowPaint);

    // Draw 12 rays with varying lengths
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);

    const rayCount = 12;
    for (var i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * math.pi;
      final isLongRay = i % 2 == 0;
      final innerRadius = sunRadius + 10;
      final outerRadius = sunRadius + (isLongRay ? 35 : 22);

      final rayPaint = Paint()
        ..color = AppColors.accent.withValues(alpha: isLongRay ? 0.6 : 0.4)
        ..strokeWidth = isLongRay ? 3.0 : 2.0
        ..strokeCap = StrokeCap.round;

      final start = Offset(
        innerRadius * math.cos(angle),
        innerRadius * math.sin(angle),
      );
      final end = Offset(
        outerRadius * math.cos(angle),
        outerRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, rayPaint);
    }

    canvas.restore();

    // Sun center gradient
    final sunGradient = RadialGradient(
      colors: [
        AppColors.secondaryLight.withValues(alpha: 0.9),
        AppColors.accent.withValues(alpha: 0.8),
      ],
    );
    final sunPaint = Paint()
      ..shader = sunGradient.createShader(
        Rect.fromCircle(center: center, radius: sunRadius),
      );
    canvas.drawCircle(center, sunRadius, sunPaint);

    // Bright center highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4);
    canvas.drawCircle(
      center - Offset(sunRadius * 0.25, sunRadius * 0.25),
      sunRadius * 0.35,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(_SunPainter oldDelegate) =>
      oldDelegate.rotationAngle != rotationAngle ||
      oldDelegate.pulseValue != pulseValue;
}

class _MoonPainter extends CustomPainter {
  _MoonPainter({
    required this.glowOpacity,
    required this.starPhase,
  });

  final double glowOpacity;
  final double starPhase;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final moonRadius = size.width * 0.2;

    // Large outer glow
    final outerGlowPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.06 * glowOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawCircle(center, moonRadius * 3.5, outerGlowPaint);

    // Medium glow
    final midGlowPaint = Paint()
      ..color = AppColors.secondaryLight.withValues(alpha: 0.12 * glowOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    canvas.drawCircle(center, moonRadius * 2, midGlowPaint);

    // Inner glow
    final innerGlowPaint = Paint()
      ..color = AppColors.secondaryLight.withValues(alpha: 0.2 * glowOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawCircle(center, moonRadius * 1.3, innerGlowPaint);

    // Draw twinkling stars first (behind moon)
    _drawStars(canvas, size, center, moonRadius);

    // Moon base (soft silver with warm tint)
    final moonColor = Color.lerp(
      const Color(0xFFE8E8E8),
      AppColors.secondaryLight,
      0.25,
    )!;

    canvas.saveLayer(
      Rect.fromCircle(center: center, radius: moonRadius * 1.1),
      Paint(),
    );

    final moonPaint = Paint()..color = moonColor;
    canvas.drawCircle(center, moonRadius, moonPaint);

    // Crescent shadow
    final shadowOffset = Offset(moonRadius * 0.45, -moonRadius * 0.1);
    final shadowPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..blendMode = BlendMode.srcIn;
    canvas.drawCircle(center + shadowOffset, moonRadius * 0.82, shadowPaint);

    canvas.restore();

    // Subtle surface details on visible part
    final detailPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15);
    canvas.drawCircle(
      center - Offset(moonRadius * 0.4, moonRadius * 0.2),
      moonRadius * 0.12,
      detailPaint,
    );
    canvas.drawCircle(
      center - Offset(moonRadius * 0.2, moonRadius * 0.5),
      moonRadius * 0.08,
      detailPaint,
    );
  }

  void _drawStars(Canvas canvas, Size size, Offset center, double moonRadius) {
    // Star positions relative to center
    final stars = [
      (offset: Offset(-moonRadius * 2.2, -moonRadius * 1.0), size: 2.5),
      (offset: Offset(moonRadius * 2.0, -moonRadius * 1.5), size: 2.0),
      (offset: Offset(-moonRadius * 1.8, moonRadius * 1.8), size: 1.8),
      (offset: Offset(moonRadius * 2.3, moonRadius * 0.8), size: 2.2),
      (offset: Offset(moonRadius * 0.5, -moonRadius * 2.2), size: 1.5),
      (offset: Offset(-moonRadius * 2.5, moonRadius * 0.3), size: 1.6),
      (offset: Offset(moonRadius * 1.2, moonRadius * 2.0), size: 1.8),
    ];

    for (var i = 0; i < stars.length; i++) {
      final star = stars[i];
      final starCenter = center + star.offset;

      // Each star twinkles at different phase
      final phaseOffset = i / stars.length;
      final twinkle = (math.sin((starPhase + phaseOffset) * 2 * math.pi) + 1) / 2;
      final opacity = 0.3 + (twinkle * 0.7);

      if (starCenter.dx > 0 &&
          starCenter.dx < size.width &&
          starCenter.dy > 0 &&
          starCenter.dy < size.height) {
        // Star glow
        final glowPaint = Paint()
          ..color = AppColors.secondaryLight.withValues(alpha: 0.3 * opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(starCenter, star.size * 2, glowPaint);

        // Star core
        final starPaint = Paint()
          ..color = Colors.white.withValues(alpha: opacity * 0.9);
        canvas.drawCircle(starCenter, star.size, starPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_MoonPainter oldDelegate) =>
      oldDelegate.glowOpacity != glowOpacity ||
      oldDelegate.starPhase != starPhase;
}
