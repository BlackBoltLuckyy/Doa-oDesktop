import 'package:flutter/material.dart';

import '../widgets/sidebar/sidebar_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Row(
        children: [
          const SidebarWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
