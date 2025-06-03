import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: centerTitle,
        automaticallyImplyLeading: showBackButton,
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
