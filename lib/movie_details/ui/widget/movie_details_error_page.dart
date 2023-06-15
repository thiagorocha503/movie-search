import 'package:flutter/material.dart';

class MovieDetailsErrorPage extends StatefulWidget {
  final String error;
  const MovieDetailsErrorPage({super.key, required this.error});

  @override
  State<MovieDetailsErrorPage> createState() => _MovieDetailsErrorPageState();
}

class _MovieDetailsErrorPageState extends State<MovieDetailsErrorPage> {
  void _close(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Error"),
              content: Text(widget.error),
              actions: [
                TextButton(
                  onPressed: () => _close(context),
                  child: const Text("Ok"),
                )
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(widget.error)));
  }
}
