import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_text_styles.dart';

/// Creative summary card with shimmer, glow, floating icon & animated counter.
class SummaryCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final LinearGradient gradient;
  final String? subtitle;
  final int animationDelay;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    this.subtitle,
    this.animationDelay = 0,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;
  late AnimationController _floatController;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: _isHovered
                ? (Matrix4.identity()
                    ..setTranslationRaw(0.0, -8.0, 0.0)
                    // ignore: deprecated_member_use
                    ..scale(1.02))
                : Matrix4.identity(),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradient.colors.first.withAlpha(
                      _isHovered ? 130 : 50,
                    ),
                    blurRadius: _isHovered ? 32 : 16,
                    offset: const Offset(0, 8),
                    spreadRadius: _isHovered ? 0 : -4,
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: widget.gradient.colors.last.withAlpha(50),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                      spreadRadius: -8,
                    ),
                ],
              ),
              child: Stack(
                children: [
                  // Shimmer overlay (web-safe)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedBuilder(
                        animation: _shimmerController,
                        builder: (context, _) {
                          return IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(
                                    -2 + 4 * _shimmerController.value,
                                    0,
                                  ),
                                  end: Alignment(
                                    -1 + 4 * _shimmerController.value,
                                    0,
                                  ),
                                  colors: [
                                    Colors.white.withAlpha(0),
                                    Colors.white.withAlpha(
                                      _isHovered ? 30 : 12,
                                    ),
                                    Colors.white.withAlpha(0),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Background decorative circle
                  Positioned(
                    right: -20,
                    top: -20,
                    child: AnimatedBuilder(
                      animation: _floatAnim,
                      builder: (context, _) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnim.value),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(
                                _isHovered ? 20 : 10,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Floating icon
                          AnimatedBuilder(
                            animation: _floatAnim,
                            builder: (context, _) {
                              return Transform.translate(
                                offset: Offset(0, _floatAnim.value * 0.5),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(
                                      _isHovered ? 60 : 40,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.white.withAlpha(30),
                                    ),
                                  ),
                                  child: Icon(
                                    widget.icon,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (widget.subtitle != null)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  _isHovered ? 50 : 30,
                                ),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withAlpha(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up_rounded,
                                    color: Colors.white.withAlpha(220),
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.subtitle!,
                                    style: AppTextStyles.cardSubtitle,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      Text(widget.value, style: AppTextStyles.cardValue),
                      const SizedBox(height: 6),
                      Text(widget.title, style: AppTextStyles.cardLabel),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.animationDelay))
        .fadeIn(duration: 700.ms, curve: Curves.easeOut)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack)
        .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
          duration: 700.ms,
        );
  }
}

/// Animated number counter that counts from 0 to target value.
class AnimatedCounter extends StatefulWidget {
  final double targetValue;
  final String prefix;
  final String suffix;
  final int decimals;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.prefix = '',
    this.suffix = '',
    this.decimals = 0,
    this.duration = const Duration(milliseconds: 1500),
    this.style,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: 0,
      end: widget.targetValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatNumber(double value) {
    if (widget.decimals > 0) {
      return '${widget.prefix}${value.toStringAsFixed(widget.decimals)}${widget.suffix}';
    }
    final intVal = value.toInt();
    final formatted = intVal.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '${widget.prefix}$formatted${widget.suffix}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Text(
          _formatNumber(_animation.value),
          style: widget.style ?? AppTextStyles.counterValue,
        );
      },
    );
  }
}
