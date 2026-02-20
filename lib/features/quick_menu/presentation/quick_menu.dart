import 'package:flutter/material.dart';

class QuickMenu extends StatefulWidget {
  const QuickMenu({super.key});

  @override
  State<QuickMenu> createState() => _QuickMenuState();
}

class _QuickMenuState extends State<QuickMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuickMenu View')),
      body: const Column(children: [Text('Welcome to the QuickMenu View!')]),
    );
  }
}
