import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  @override
  final Size preferredSize;
  final String title;
  final List<Widget> _actions;
  static const padding = 15;

  CustomAppBar({super.key, required this.title, List<Widget>? actions})
      : preferredSize = const Size.fromHeight(kToolbarHeight + padding),
        _actions = actions ?? [];

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          toolbarHeight: kToolbarHeight + padding,
          shadowColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: primeGradient,
            ),
          ),
          actions: [
            ..._actions,
            // IconButton(
            //     onPressed: () => navigate(context, "/add"),
            //     icon: const Icon(
            //       Icons.add,
            //       color: Colors.white,
            //       size: 30.0,
            //     )),
            const SizedBox(width: 15)
          ],
        ));
  }

  @override
  Widget get child => Container();
}
