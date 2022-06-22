import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Edit Profile",
        ),
      ),
      body: EditProfileScreen(),
    );
  }
}
