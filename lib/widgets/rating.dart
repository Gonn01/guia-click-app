// import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:guia_click/extensions/date_time.dart';
import 'package:guia_click/models/rating.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    required this.rating,
    super.key,
  });
  final Rating rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey[300],
            child: Image.network(
              'https://static.vecteezy.com/system/resources/previews/020/911/733/large_2x/profile-icon-avatar-icon-user-icon-person-icon-free-png.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    rating.comment,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(rating.createdAt.toLocal().formatDateTime),
                    RatingBar.readOnly(
                      size: 20,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: rating.rating.toDouble(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
