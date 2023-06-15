import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/movie_details/bloc/bloc.dart';
import 'package:movie_search_app/movie_details/model/movie.dart';
import 'package:movie_search_app/movie_details/ui/widget/backdrop.dart';
import 'package:movie_search_app/movie_details/ui/widget/movie_details_error_page.dart';
import 'package:movie_search_app/movie_details/ui/widget/movie_details_loading_page.dart';
import 'package:movie_search_app/repository/movie_repository.dart';

class MovieDetails extends StatefulWidget {
  final String title;
  final int id;
  const MovieDetails({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailsBloc bloc;

  // late bloc initialization
  @override
  void didChangeDependencies() {
    bloc = MovieDetailsBloc(
      initialState: MovieDetailsInitialState(),
      repository: context.watch<IMovieRepository>(),
    )..add(
        MovieDetailsFetched(
          id: widget.id,
          language: context.read<LanguageCubit>().state,
        ),
      );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is MovieDetailsLoaded) {
          return MovieDeatilsPageSucess(
            movie: state.movie,
          );
        } else if (state is MovieDetailsError) {
          return MovieDetailsErrorPage(error: state.error);
        } else {
          return const MovieDetailsLoadingPage();
        }
      },
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MovieDeatilsPageSucess extends StatelessWidget {
  final Movie movie;

  const MovieDeatilsPageSucess({super.key, required this.movie});

  final posterHeight = 150.0;
  final posterWidth = 100.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Backdrop(movie: movie),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (movie.tagline != "")
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          movie.tagline,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    Wrap(
                      children: movie.genres
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: Chip(
                                label: Text(e.name),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    if (movie.overview != "") ...[
                      const Text(
                        "Overview",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(movie.overview)
                    ]
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
