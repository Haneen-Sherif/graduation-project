import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      body: ProfileViewBody(
        id: id,
      ),
    );
  }
}
