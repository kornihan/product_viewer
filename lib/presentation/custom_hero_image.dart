import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomHeroImage extends StatelessWidget {
  final String image;
  const CustomHeroImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: image,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
