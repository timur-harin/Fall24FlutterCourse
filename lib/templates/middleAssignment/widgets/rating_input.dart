import 'package:flutter/material.dart';

class RatingInput extends StatelessWidget {
  final double initialRating;
  final Function(double) onRatingChanged;

  const RatingInput({
    Key? key,
    this.initialRating = 0,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < initialRating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 40,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }
}
