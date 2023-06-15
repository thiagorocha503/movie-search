import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:movie_search_app/movie_details/ui/movie_details_page.dart';
import 'package:movie_search_app/movie_overview/model/movie_preview.dart';

class MovieCard extends StatefulWidget {
  final MoviePreview movie;
  const MovieCard({required this.movie, super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void _onTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MovieDetails(title: widget.movie.title, id: widget.movie.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap(context);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: CachedNetworkImage(
                height: 188,
                width: 125,
                imageUrl:
                    "https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                placeholder: (context, url) => const SizedBox(
                  height: 188,
                  width: 125,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.movie.title} (${widget.movie.releaseDate.year})",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Text(
                      widget.movie.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
