import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class LineGridAnimation extends StatefulWidget {
  final double opacity;
  
  const LineGridAnimation({super.key, this.opacity = 0.07});

  @override
  State<LineGridAnimation> createState() => _LineGridAnimationState();
}

class _LineGridAnimationState extends State<LineGridAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _GridPainter(_controller.value, widget.opacity),
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  final double progress;
  final double baseOpacity;

  _GridPainter(this.progress, this.baseOpacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: baseOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.max(size.width, size.height) * 0.8;

    // Draw static circles (matching the SVG scale)
    canvas.drawCircle(center, maxRadius * 0.2, paint);
    canvas.drawCircle(center, maxRadius * 0.45, paint);
    canvas.drawCircle(center, maxRadius * 0.7, paint);

    // Draw static lines
    // Vertical
    canvas.drawLine(Offset(center.dx, -size.height), Offset(center.dx, size.height * 2), paint);
    // Horizontal
    canvas.drawLine(Offset(-size.width, center.dy), Offset(size.width * 2, center.dy), paint);
    // Diagonals (using arbitrary points outside screen to ensure they cross full screen)
    canvas.drawLine(Offset(-size.width, -size.height), Offset(size.width * 2, size.height * 2), paint);
    canvas.drawLine(Offset(-size.width, size.height * 2), Offset(size.width * 2, -size.height), paint);

    // Draw shooting light particles/lines
    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // A helper to draw a shooting line along a path
    void drawShootingLine(Offset start, Offset end, double offsetTime, double speedMultiplier) {
      double t = (progress * speedMultiplier + offsetTime) % 1.0;
      
      // Fast burst: only visible for a fraction of the time
      if (t > 0.6) return; 
      
      double normalizedT = t / 0.6;
      
      final length = (end - start).distance;
      if (length == 0) return;
      final direction = (end - start) / length;
      
      // Particle length
      final particleLength = length * 0.3;
      
      final currentPos = start + direction * (length * normalizedT);
      final tailPos = currentPos - direction * particleLength;
      
      highlightPaint.shader = ui.Gradient.linear(
        tailPos,
        currentPos,
        [Colors.white.withValues(alpha: 0), Colors.white.withValues(alpha: baseOpacity * 6)],
      );
      
      canvas.drawLine(tailPos, currentPos, highlightPaint);
    }

    // Shoot across the lines
    drawShootingLine(Offset(-size.width, center.dy), Offset(size.width * 2, center.dy), 0.0, 1.0);
    drawShootingLine(Offset(size.width * 2, center.dy), Offset(-size.width, center.dy), 0.4, 1.2);
    
    drawShootingLine(Offset(center.dx, -size.height), Offset(center.dx, size.height * 2), 0.2, 1.5);
    drawShootingLine(Offset(center.dx, size.height * 2), Offset(center.dx, -size.height), 0.7, 1.3);

    drawShootingLine(Offset(-size.width, -size.height), Offset(size.width * 2, size.height * 2), 0.1, 1.4);
    drawShootingLine(Offset(size.width * 2, -size.height), Offset(-size.width, size.height * 2), 0.6, 1.6);
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => progress != oldDelegate.progress;
}
