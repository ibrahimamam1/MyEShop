import 'package:flutter/material.dart';

class ShimmerLoadingEffect extends StatefulWidget {
  final double width;
  final double height;
  final int itemCount;
  final double spacing;
  final bool isHorizontal;

  const ShimmerLoadingEffect({
    super.key,
    this.width = 60,
    this.height = 80,
    this.itemCount = 6,
    this.spacing = 8.0,
    this.isHorizontal = true,
  });

  @override
  _ShimmerLoadingEffectState createState() => _ShimmerLoadingEffectState();
}

class _ShimmerLoadingEffectState extends State<ShimmerLoadingEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.grey[100],
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isHorizontal ? widget.height : null,
      width: widget.isHorizontal ? null : widget.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.itemCount,
        scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isHorizontal ? widget.spacing / 2 : 0,
              vertical: widget.isHorizontal ? 0 : widget.spacing / 2,
            ),
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: widget.width * 0.8,
                      height: widget.height * 0.6,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: widget.height * 0.05),
                    Container(
                      width: widget.width,
                      height: widget.height * 0.15,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
