import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class SteppeLandscapeWidget extends StatefulWidget {
  const SteppeLandscapeWidget({this.height = 180, super.key});

  final double height;

  @override
  State<SteppeLandscapeWidget> createState() => _SteppeLandscapeWidgetState();
}

class _SteppeLandscapeWidgetState extends State<SteppeLandscapeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _smokeController;

  bool get _isMorning {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 17;
  }

  @override
  void initState() {
    super.initState();
    _smokeController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _smokeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _smokeController,
          builder: (context, _) {
            return CustomPaint(
              size: Size(double.infinity, widget.height),
              painter: _SteppePainter(
                isMorning: _isMorning,
                smokePhase: _smokeController.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SteppePainter extends CustomPainter {
  _SteppePainter({
    required this.isMorning,
    required this.smokePhase,
  });

  final bool isMorning;
  final double smokePhase;

  @override
  void paint(Canvas canvas, Size size) {
    // Colors based on time of day
    final groundColor = isMorning
        ? AppColors.secondary
        : AppColors.secondaryDark.withValues(alpha: 0.8);
    final hillColorFar = isMorning
        ? AppColors.primaryDark.withValues(alpha: 0.3)
        : AppColors.primaryDark.withValues(alpha: 0.5);
    final hillColorMid = isMorning
        ? AppColors.primaryDark.withValues(alpha: 0.45)
        : AppColors.primaryDark.withValues(alpha: 0.65);
    final hillColorNear = isMorning
        ? AppColors.primary.withValues(alpha: 0.5)
        : AppColors.primaryDark.withValues(alpha: 0.75);

    // Draw distant hills (back layer)
    _drawHills(
      canvas,
      size,
      color: hillColorFar,
      baseY: size.height * 0.35,
      amplitude: 25,
      frequency: 1.5,
      phaseOffset: 0.5,
    );

    // Draw middle hills
    _drawHills(
      canvas,
      size,
      color: hillColorMid,
      baseY: size.height * 0.5,
      amplitude: 20,
      frequency: 2.0,
      phaseOffset: 1.2,
    );

    // Draw near hills
    _drawHills(
      canvas,
      size,
      color: hillColorNear,
      baseY: size.height * 0.65,
      amplitude: 15,
      frequency: 2.5,
      phaseOffset: 2.0,
    );

    // Draw ground
    final groundPaint = Paint()..color = groundColor;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.7, size.width, size.height * 0.3),
      groundPaint,
    );

    // Draw grass tufts
    _drawGrassTufts(canvas, size);

    // Draw yurts
    _drawYurt(
      canvas,
      centerX: size.width * 0.2,
      groundY: size.height * 0.85,
      yurtWidth: 50,
      isMorning: isMorning,
    );

    _drawYurt(
      canvas,
      centerX: size.width * 0.8,
      groundY: size.height * 0.82,
      yurtWidth: 40,
      isMorning: isMorning,
    );

    // Small distant yurt
    _drawYurt(
      canvas,
      centerX: size.width * 0.55,
      groundY: size.height * 0.72,
      yurtWidth: 25,
      isMorning: isMorning,
    );

    // Draw smoke from yurts
    if (!isMorning) {
      _drawSmoke(canvas, size.width * 0.2, size.height * 0.58, smokePhase);
      _drawSmoke(canvas, size.width * 0.8, size.height * 0.56, smokePhase + 0.3);
    }
  }

  void _drawHills(
    Canvas canvas,
    Size size, {
    required Color color,
    required double baseY,
    required double amplitude,
    required double frequency,
    required double phaseOffset,
  }) {
    final path = Path();
    path.moveTo(0, size.height);

    for (var x = 0.0; x <= size.width; x += 2) {
      final normalizedX = x / size.width;
      final y = baseY +
          amplitude * math.sin((normalizedX * frequency + phaseOffset) * math.pi * 2) +
          amplitude * 0.5 * math.sin((normalizedX * frequency * 2.3 + phaseOffset * 1.5) * math.pi * 2);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, Paint()..color = color);
  }

  void _drawGrassTufts(Canvas canvas, Size size) {
    final grassColor = isMorning
        ? AppColors.primary.withValues(alpha: 0.4)
        : AppColors.primaryDark.withValues(alpha: 0.5);

    final random = math.Random(42); // Fixed seed for consistent placement
    final grassPaint = Paint()
      ..color = grassColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = size.height * 0.75 + random.nextDouble() * size.height * 0.2;

      // Draw 3-5 blades per tuft
      final bladeCount = 3 + random.nextInt(3);
      for (var j = 0; j < bladeCount; j++) {
        final bladeHeight = 6 + random.nextDouble() * 8;
        final angle = -0.3 + random.nextDouble() * 0.6;
        final endX = x + bladeHeight * math.sin(angle);
        final endY = y - bladeHeight * math.cos(angle);
        canvas.drawLine(Offset(x, y), Offset(endX, endY), grassPaint);
      }
    }
  }

  void _drawYurt(
    Canvas canvas, {
    required double centerX,
    required double groundY,
    required double yurtWidth,
    required bool isMorning,
  }) {
    final yurtHeight = yurtWidth * 0.7;
    final domeHeight = yurtHeight * 0.45;
    final wallHeight = yurtHeight * 0.55;

    // Colors
    final feltColor = isMorning
        ? AppColors.secondaryLight
        : AppColors.secondary.withValues(alpha: 0.7);
    final trimColor = isMorning
        ? AppColors.accent
        : AppColors.accent.withValues(alpha: 0.6);
    final doorColor = isMorning
        ? AppColors.secondaryDark
        : AppColors.secondaryDark.withValues(alpha: 0.8);

    // Wall (rectangle)
    final wallRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, groundY - wallHeight / 2),
        width: yurtWidth,
        height: wallHeight,
      ),
      const Radius.circular(2),
    );
    canvas.drawRRect(wallRect, Paint()..color = feltColor);

    // Dome (arc)
    final domePath = Path();
    domePath.moveTo(centerX - yurtWidth / 2, groundY - wallHeight);
    domePath.quadraticBezierTo(
      centerX,
      groundY - wallHeight - domeHeight,
      centerX + yurtWidth / 2,
      groundY - wallHeight,
    );
    domePath.close();
    canvas.drawPath(domePath, Paint()..color = feltColor);

    // Trim band at top of wall
    final trimRect = Rect.fromCenter(
      center: Offset(centerX, groundY - wallHeight + 3),
      width: yurtWidth,
      height: 5,
    );
    canvas.drawRect(trimRect, Paint()..color = trimColor);

    // Door
    final doorWidth = yurtWidth * 0.25;
    final doorHeight = wallHeight * 0.6;
    final doorRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        centerX - doorWidth / 2,
        groundY - doorHeight,
        doorWidth,
        doorHeight,
      ),
      Radius.circular(doorWidth / 2),
    );
    canvas.drawRRect(doorRect, Paint()..color = doorColor);

    // Shanyrak (crown) - small circle at top
    final shanyrakPaint = Paint()
      ..color = trimColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(
      Offset(centerX, groundY - wallHeight - domeHeight * 0.6),
      yurtWidth * 0.08,
      shanyrakPaint,
    );
  }

  void _drawSmoke(Canvas canvas, double x, double y, double phase) {
    // Draw 3 smoke puffs at different heights
    for (var i = 0; i < 3; i++) {
      final puffPhase = (phase + i * 0.33) % 1.0;
      final puffY = y - puffPhase * 40;
      final puffX = x + math.sin(puffPhase * math.pi * 2) * 8;
      final puffSize = 6 + (1 - puffPhase) * 6;
      final puffOpacity = (1 - puffPhase) * 0.3;

      canvas.drawCircle(
        Offset(puffX, puffY),
        puffSize,
        Paint()
          ..color = Colors.white.withValues(alpha: puffOpacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }
  }

  @override
  bool shouldRepaint(_SteppePainter oldDelegate) =>
      oldDelegate.isMorning != isMorning || oldDelegate.smokePhase != smokePhase;
}
