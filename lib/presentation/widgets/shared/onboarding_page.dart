import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isVisible; // Added to control animation

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isVisible = true, // Default to true for compatibility
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatingImage(
            image: image,
            height: 200,
            width: 200,
            isVisible: isVisible, // Pass visibility to control animation
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 28.32,
              fontFamily: 'ExtraBold',
              fontWeight: FontWeight.w900,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 33, 33, 33),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RotatingImage extends StatefulWidget {
  final String image;
  final double height;
  final double width;
  final bool isVisible;

  const RotatingImage({
    super.key,
    required this.image,
    this.height = 200,
    this.width = 200,
    required this.isVisible,
  });

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    if (widget.isVisible) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.repeat();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.stop();
    }
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
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: Image.asset(
            widget.image,
            height: widget.height,
            width: widget.width,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
