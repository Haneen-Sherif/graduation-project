import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _showExitConfirmationDialog(context),
      child: const Column(),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Exit App',
                style: TextStyle(color: kSecondaryColor),
              ),
              content: const Text(
                'Do you want to close the app?',
                style: TextStyle(color: kSecondaryColor),
              ),
              backgroundColor: kPrimaryColor,
              actions: <Widget>[
                _buildDialogButton(context, 'No', false),
                _buildDialogButton(context, 'Yes', true),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildDialogButton(BuildContext context, String text, bool value) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(value),
      child: Text(
        text,
        style: const TextStyle(color: kSecondaryColor),
      ),
    );
  }
}
