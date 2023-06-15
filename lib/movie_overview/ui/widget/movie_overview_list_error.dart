import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/movie_overview/bloc/bloc.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';

class MovieOverviewListError extends StatelessWidget {
  final String error;
  const MovieOverviewListError({super.key, required this.error});

  void _refresh(BuildContext context) {
    context.read<MovieOverviewBloc>().add(
          MovieOverviewFetched(
            list: MovieList.popular,
            lang: context.read<LanguageCubit>().state,
            page: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var size = MediaQuery.of(context).size;
        return RefreshIndicator(
          child: ListView(
            children: [
              SizedBox(
                height: size.height - (AppBar().preferredSize.height),
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        error,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _refresh(context),
                      child: const Text("Try again"),
                    )
                  ],
                ),
              )
            ],
          ),
          onRefresh: () async {
            _refresh(context);
          },
        );
      },
    );
  }
}

/*
Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Error"),
            Text(error),
            ElevatedButton(
              onPressed: () => _refresh(context),
              child: const Text("Try again"),
            )
          ],
        ),
*/
