import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_app/language/bloc/language_cubit.dart';
import 'package:movie_search_app/language/model/language.dart';
import 'package:movie_search_app/language/ui/language_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _onTapLanguage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LanguagePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: BlocBuilder<LanguageCubit, Language>(
              builder: (context, state) =>
                  Text(context.read<LanguageCubit>().state.name),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _onTapLanguage(context),
          )
        ],
      ),
    );
  }
}
