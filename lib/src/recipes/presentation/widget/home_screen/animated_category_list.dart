// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dribbble_challenge/src/recipes/presentation/widget/home_screen/food_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedCategoryList extends StatelessWidget {
  final BoxConstraints constraints;
  final Duration categoryListPlayDuration;
  final Duration categoryListDelayDuration;
  const AnimatedCategoryList({
    Key? key,
    required this.constraints,
    required this.categoryListPlayDuration,
    required this.categoryListDelayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: constraints.maxHeight * 0.16,
        height: 45,
        width: constraints.maxWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 15),
          children: List.generate(
                  _categories.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: _categories[index],
                      ))
              .animate(interval: 100.ms, delay: categoryListDelayDuration)
              .slideX(
                  duration: categoryListPlayDuration,
                  begin: 3,
                  end: 0,
                  curve: Curves.easeInOutSine),
        ));
  }
}

const _categories = [
  FoodCategoryWidget(icon: "🔥", name: "热门"),
  FoodCategoryWidget(icon: "🥦", name: "健康"),
  FoodCategoryWidget(icon: "🍲", name: "汤"),
  FoodCategoryWidget(icon: "🍿", name: "点心"),
];
