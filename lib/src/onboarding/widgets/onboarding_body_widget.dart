import 'package:dribbble_challenge/src/onboarding/widgets/onboarding_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnBoardingBodyWidget extends StatefulWidget {
  const OnBoardingBodyWidget({super.key});

  @override
  State<OnBoardingBodyWidget> createState() => _OnBoardingBodyWidgetState();
}

class _OnBoardingBodyWidgetState extends State<OnBoardingBodyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isAnimating = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainPlayDuration = 1000.ms;
    final leavesDelayDuration = 600.ms;
    final titleDelayDuration = mainPlayDuration + 50.ms;
    final descriptionDelayDuration = titleDelayDuration + 300.ms;
    final buttonDelayDuration = descriptionDelayDuration + 100.ms;

    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight * 0.60,
            child: AnimatedDishWidget(
              dishPlayDuration: mainPlayDuration,
              leavesDelayDuration: leavesDelayDuration,
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.12,
            child: AnimatedTitleWidget(
                titleDelayDuration: titleDelayDuration,
                width: constraint.maxWidth,
                mainPlayDuration: mainPlayDuration),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.02,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.07,
            child: AnimatedDescriptionWidget(
                descriptionPlayDuration: mainPlayDuration,
                descriptionDelayDuration: descriptionDelayDuration,
                width: constraint.maxWidth),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          SizedBox(
            child: GestureDetector(
              onTap: () {
                if (_isAnimating) return;

                _isAnimating = true;
                _controller.forward();

                // 定义一个局部变量存储监听器函数
                late AnimationStatusListener listener;
                listener = (status) {
                  if (status == AnimationStatus.completed) {
                    _controller.removeStatusListener(listener); // 移除当前监听器

                    Future.delayed(400.ms, () {
                      if (mounted) {
                        Navigator.of(context).pushReplacementNamed('home');
                        _isAnimating = false;
                      }
                    });
                  }
                };

                _controller.addStatusListener(listener); // 添加监听器
              },
              child: AnimatedButtonWidget(
                  width: constraint.maxWidth,
                  buttonDelayDuration: buttonDelayDuration,
                  buttonPlayDuration: mainPlayDuration),
            ),
          )
        ],
      )
          .animate(
            autoPlay: false,
            controller: _controller,
          )
          .blurXY(begin: 0, end: 25, duration: 600.ms, curve: Curves.easeInOut)
          .scaleXY(begin: 1, end: 0.6)
          .fadeOut(
            begin: 1,
          );
    });
  }
}
