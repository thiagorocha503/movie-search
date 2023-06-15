import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/movie_overview/bloc/bloc.dart';
import 'package:movie_search_app/movie_overview/model/movie_list.dart';
import 'package:movie_search_app/movie_overview/ui/widget/movie_card.dart';
import 'package:movie_search_app/movie_overview/ui/widget/movie_overview_list_error.dart';
import 'package:movie_search_app/settings/ui/setting_pages.dart';

class MovieOverviewPage extends StatefulWidget {
  final String title;

  const MovieOverviewPage({super.key, required this.title});

  @override
  State<MovieOverviewPage> createState() => _MovieOverviewPageState();
}

class _MovieOverviewPageState extends State<MovieOverviewPage> {
  final _scrollController = ScrollController();
  bool block = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onTapSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () => _onTapSetting(context),
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
      body: BlocBuilder<MovieOverviewBloc, MovieOverviewState>(
        builder: (context, state) {
          if (state is MovieOverviewLoaded) {
            block = false;
            return RefreshIndicator(
              onRefresh: () async => context.read<MovieOverviewBloc>().add(
                    MovieOverviewFetched(
                        list: MovieList.popular,
                        lang: context.read<LanguageCubit>().state,
                        page: 1),
                  ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.page == state.totalPages
                    ? state.movies.length
                    : state.movies.length + 1,
                itemBuilder: (context, index) => index >= state.movies.length
                    ? const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : MovieCard(
                        movie: state.movies[index],
                      ),
              ),
            );
          } else if (state is MovieOverviewError) {
            return MovieOverviewListError(error: state.error);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // https://bloclibrary.dev/#/flutterinfinitelisttutoria
  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // https://bloclibrary.dev/#/flutterinfinitelisttutorial
  void _onScroll() {
    if (_isBottom && !block) {
      if (context.read<MovieOverviewBloc>().state is MovieOverviewLoaded) {
        context.read<MovieOverviewBloc>().add(
              MovieOverviewFetched(
                list: MovieList.popular,
                page: (context.read<MovieOverviewBloc>().state
                            as MovieOverviewLoaded)
                        .page +
                    1,
                lang: context.read<LanguageCubit>().state,
              ),
            );
      }
      block = true;
    }
  }

  // https://bloclibrary.dev/#/flutterinfinitelisttutorial
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
