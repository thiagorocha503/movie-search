import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/util/convertion.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List<Language> langs = [
    stringToLanguage("en-US"),
    stringToLanguage("es"),
    stringToLanguage("pt-BR")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Language"),
      ),
      body: BlocBuilder<LanguageCubit, Language>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: langs.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(langs[index].name),
              trailing: state.code == langs[index].code
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                context.read<LanguageCubit>().change(langs[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
