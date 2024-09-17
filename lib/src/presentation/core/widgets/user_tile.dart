import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String displayName;
  final String email;
  final Function() onTap;
  const UserTile({super.key, required this.displayName, required this.email, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        textColor: Colors.white,
        tileColor: Theme.of(context).primaryColor,
        selectedColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(displayName),
        subtitle: Text(email),
      ),
    );
  }
}
