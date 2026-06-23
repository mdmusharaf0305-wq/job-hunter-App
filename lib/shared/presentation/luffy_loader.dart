import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LuffyLoader extends StatefulWidget {
  final double size;
  final String? loadingText;

  const LuffyLoader({
    super.key,
    this.size = 16.0,
    this.loadingText,
  });

  @override
  State<LuffyLoader> createState() => _LuffyLoaderState();
}

class _LuffyLoaderState extends State<LuffyLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progress = 0.0;
  late math.Random _random;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _random = math.Random();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_progress < 30) {
          _progress += _random.nextDouble() * 4.0 + 2.0;
        } else if (_progress < 70) {
          _progress += _random.nextDouble() * 1.5 + 0.5;
        } else if (_progress < 90) {
          _progress += _random.nextDouble() * 0.5 + 0.1;
        } else if (_progress < 98) {
          _progress += _random.nextDouble() * 0.1 + 0.02;
        } else {
          _progress += (99.0 - _progress) * 0.1;
        }
        if (_progress > 99.0) _progress = 99.0;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFullPage = widget.size >= 32.0;

    if (!isFullPage) {
      // Inline compact loader
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulseIndicator(isDark: isDark),
          const SizedBox(width: 6),
          Text(
            '${_progress.toStringAsFixed(1)}%',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.darkAccentBlue,
            ),
          ),
        ],
      );
    }

    // Full page card loader
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 220),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x1F2A2A3E) : Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0x1FFFFFFF) : const Color(0x14000000),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Centered capsule containing the custom painter animation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0x90000000) : const Color(0xFFEFFFFA),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDark ? const Color(0x2BFFFFFF) : const Color(0x40B2F2E4),
                width: 1,
              ),
            ),
            child: SizedBox(
              width: 120,
              height: 38,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LuffyWalkPainter(
                      animationValue: _controller.value,
                      isDark: isDark,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Progress metrics text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.loadingText ?? 'SCANNING OPPORTUNITIES...',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: isDark ? AppColors.darkAccentBlue : AppColors.lightAccentBlue,
                ),
              ),
              Text(
                '${_progress.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  color: isDark ? const Color(0xFF0F0F15) : const Color(0xFFE5E7EB),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: MediaQuery.of(context).size.width *
                      0.65 *
                      (_progress / 100.0),
                  height: 6,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.darkAccentBlue,
                        AppColors.darkAccentPurple,
                        Color(0xFF22D3EE),
                      ],
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

class _PulseIndicator extends StatefulWidget {
  final bool isDark;
  const _PulseIndicator({required this.isDark});

  @override
  State<_PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<_PulseIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 10 * (1.0 + _controller.value * 0.8),
              height: 10 * (1.0 + _controller.value * 0.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (widget.isDark ? AppColors.darkAccentBlue : AppColors.lightAccentBlue)
                    .withOpacity(0.6 * (1.0 - _controller.value)),
              ),
            ),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isDark ? AppColors.darkAccentBlue : AppColors.lightAccentBlue,
              ),
            ),
          ],
        );
      },
    );
  }
}

class LuffyWalkPainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  LuffyWalkPainter({
    required this.animationValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw capsule background glow (light radial overlay)
    final capPaint = Paint()
      ..color = isDark
          ? const Color(0x1F8B5CF6)
          : const Color(0x10059669);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(19),
      ),
      capPaint,
    );

    // 2. Draw ground dash-line
    final groundPaint = Paint()
      ..color = isDark ? const Color(0x406366F1) : const Color(0x606366F1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw a dashed ground line at y = 35
    const double groundY = 34.0;
    const double dashWidth = 3.0;
    const double dashSpace = 3.0;
    double startX = 10.0;
    while (startX < size.width - 10) {
      canvas.drawLine(
        Offset(startX, groundY),
        Offset(startX + dashWidth, groundY),
        groundPaint,
      );
      startX += dashWidth + dashSpace;
    }

    // 3. Compute walk translation cycle (walking from X = -20 to X = 100)
    // At animationValue = 0, x = -20. At 1.0, x = 100.
    double x = -20.0 + (animationValue * 120.0);
    
    // Compute opacity fade in / fade out at edges
    double opacity = 1.0;
    if (animationValue < 0.15) {
      opacity = animationValue / 0.15;
    } else if (animationValue > 0.85) {
      opacity = (1.0 - animationValue) / 0.15;
    }

    canvas.save();
    canvas.translate(x, 0);

    // Animations calculations
    final angleSpeed = animationValue * 2 * math.pi * 4; // 4 cycles of leg swing per walk loop
    final legAngle = math.sin(angleSpeed) * 0.38; // swing angle in radians (approx 22 deg)
    final armAngle = math.sin(angleSpeed) * 0.21; // arm swing in radians (approx 12 deg)
    final headBob = (math.sin(angleSpeed * 2) * 0.6).abs(); // head bobbing down/up

    // Paint options
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFA5B4FC),
          Color(0xFF6366F1),
          Color(0xFF312E81),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(const Rect.fromLTWH(29, 14, 9, 32))
      ..color = Colors.indigo.withOpacity(opacity);

    final leg1Paint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(opacity)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final leg2Paint = Paint()
      ..color = const Color(0xFF4F46E5).withOpacity(opacity)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final armPaint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(opacity)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    // A. Draw Left Leg (swinging)
    canvas.save();
    canvas.translate(30.5, 27.0);
    canvas.rotate(legAngle);
    canvas.drawLine(const Offset(0, 0), const Offset(-4, 7), leg1Paint);
    canvas.restore();

    // B. Draw Right Leg (swinging opposite)
    canvas.save();
    canvas.translate(33.5, 27.0);
    canvas.rotate(-legAngle);
    canvas.drawLine(const Offset(0, 0), const Offset(4, 7), leg2Paint);
    canvas.restore();

    // C. Draw Torso (X bounds: 29 to 35, Y bounds: 16 to 27)
    final torsoRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(29, 16, 6, 11),
      const Radius.circular(2.0),
    );
    canvas.drawRRect(torsoRect, bodyPaint);

    // D. Draw Arm with briefcase (swinging)
    canvas.save();
    canvas.translate(32.0, 18.0);
    canvas.rotate(armAngle);
    
    // Arm line
    canvas.drawLine(const Offset(2, 0), const Offset(6, 9), armPaint);
    
    // Briefcase Paint (Vibrant orange gradient)
    final casePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFBBF24),
          Color(0xFFF59E0B),
          Color(0xFFDC2626),
        ],
      ).createShader(const Rect.fromLTWH(4.0, 7.5, 10, 7))
      ..color = Colors.orange.withOpacity(opacity);

    final caseOutline = Paint()
      ..color = const Color(0xFF1E1B4B).withOpacity(opacity)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw Briefcase
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(4.0, 7.5, 10, 7),
        const Radius.circular(1.5),
      ),
      casePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(4.0, 7.5, 10, 7),
        const Radius.circular(1.5),
      ),
      caseOutline,
    );
    // Draw Briefcase handle
    final handlePath = Path()
      ..moveTo(7.0, 7.5)
      ..lineTo(7.0, 6.0)
      ..lineTo(11.0, 6.0)
      ..lineTo(11.0, 7.5);
    canvas.drawPath(handlePath, caseOutline);

    canvas.restore();

    // E. Draw Head (bobbing)
    canvas.save();
    canvas.translate(32.0, 13.0 + headBob);
    canvas.drawCircle(Offset.zero, 3.5, bodyPaint);
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant LuffyWalkPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isDark != isDark;
  }
}
