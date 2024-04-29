import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/profile_view_2_body.dart';

class ProfileView2 extends StatelessWidget {
  const ProfileView2({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      body: ProfileView2Body(
        id: id,
      ),
    );
  }
}
