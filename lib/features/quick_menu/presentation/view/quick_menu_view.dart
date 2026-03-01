import 'package:flutter/material.dart';

class QuickMenuView extends StatefulWidget {
  const QuickMenuView({super.key});

  @override
  State<QuickMenuView> createState() => _QuickMenuViewState();
}

class _QuickMenuViewState extends State<QuickMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuickMenu View')),
      body: const Column(children: [Text('Welcome to the QuickMenu View!')]),
    );
  }
}
