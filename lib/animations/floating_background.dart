import 'package:flutter/material.dart';

class FloatingVertical extends StatefulWidget {
  final List<List<String>> images;

  const FloatingVertical({super.key, required this.images});

  @override
  State<FloatingVertical> createState() => _FloatingVerticalState();
}

class _FloatingVerticalState extends State<FloatingVertical>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.images.length, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(seconds: 18 + (i * 4)),
      )..repeat();
    });

    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0, end: -1).animate(
        CurvedAnimation(parent: c, curve: Curves.linear),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox.expand(
      child: Row(
        children: List.generate(widget.images.length, (col) {
          return Expanded(
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _animations[col],
                builder: (_, child) {
                  return Transform.translate(
                    offset: Offset(0, _animations[col].value * screenHeight),
                    child: child,
                  );
                },
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    // first list
                    ...widget.images[col].map((img) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Image.asset(img, height: 120),
                        )),
                    // duplicate for looping
                    ...widget.images[col].map((img) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Image.asset(img, height: 120),
                        )),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}