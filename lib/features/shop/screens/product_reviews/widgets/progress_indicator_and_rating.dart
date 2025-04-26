import 'package:baakas_seller/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:flutter/material.dart';

class BaakasOverallProductRating extends StatelessWidget {
  const BaakasOverallProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text('4.8', style: Theme.of(context).textTheme.displayLarge),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              BaakasRatingProgressIndicator(text: '5', value: 1.0),
              BaakasRatingProgressIndicator(text: '4', value: 0.8),
              BaakasRatingProgressIndicator(text: '3', value: 0.6),
              BaakasRatingProgressIndicator(text: '2', value: 0.4),
              BaakasRatingProgressIndicator(text: '1', value: 0.2),
            ],
          ),
        ),
      ],
    );
  }
}
