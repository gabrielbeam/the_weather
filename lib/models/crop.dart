import 'package:flutter/material.dart';

class Crop {
  final String imageUrl;
  final String name;
  final String information;

  Crop({
    required this.imageUrl,
    required this.name,
    required this.information,
  });

  static List<Crop> generateCropsList() {
    return [
      Crop(
        imageUrl: 'assets/images/corn.png',
        name: 'Corn',
        information: '''
1. Germination and Seedling Stage (0-25 days):
   Water Requirement: Low to moderate (3–4 mm/day).
2. Vegetative Stage (25-55 days):
   Water Requirement: Increasing(5–6 mm/day).
3. Flowering (55-75 days):
   Water Requirement: Peak demand (7–8 mm/day).
4. Grain Filling and Maturity (75-110 days):
   Water Requirement: Decreasing. (4–5 mm/day).
      '''),
      Crop(
        imageUrl: 'assets/images/sugar_cane.png',
        name: '⁠Sugar Cane',
        information: '''
1. Germination (0-30 days):
   Water Requirement: Moderate (2–4 mm/day)
2. Tillering (30-120 days):
   Water Requirement: Increasing (4–6 mm/day)
3. Grand Growth Phase (120-270 days):
   Water Requirement: Highest demand (8–10 mm/day)
4. Maturation (270-360 days):
   Water Requirement: Decreasing (5–7 mm/day)
        ''',
      ),
      Crop(
        imageUrl: 'assets/images/oil_palm.png',
        name: 'Oil Palm',
        information: '''
1. Nursery Stage (Seedling to 1 year):
   Water Requirement: Moderate (3–5 mm/day)
2. Immature Stage (1-3 years):
   Water Requirement: Increasing (5–6 mm/day)
3. Mature Stage (3+ years):
   Water Requirement: Consistently high (6–8 mm/day)
        ''',
      ),
    ];
  }
}