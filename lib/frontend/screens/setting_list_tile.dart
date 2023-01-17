import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  final void Function() onTap;
  final Widget leading;
  final Widget title;
  final Widget? trailing;

  const SettingListTile({
    Key? key,
    required this.onTap,
    required this.leading,
    required this.title,
    this.trailing = const Icon(Icons.arrow_forward_ios_outlined),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: title,
        trailing: trailing,
      ),
    );
  }
}