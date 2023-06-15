import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:movie_search_app/movie_details/model/movie.dart';

const double originalBackdropWidth = 1920;
const double originalBackdropHeight = 1080;

class Backdrop extends StatelessWidget {
  final Movie movie;
  const Backdrop({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = MediaQuery.of(context).size.width;
      double height = ((originalBackdropHeight * width) / originalBackdropWidth)
          .roundToDouble();
      if (movie.backdropPath == null) {
        return Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(color: Colors.grey),
        );
      }
      return CachedNetworkImage(
        imageUrl: "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
        placeholder: (context, url) => Container(
          decoration: const BoxDecoration(color: Colors.grey),
          height: height,
          width: width,
        ),
      );
    });
  }
}
