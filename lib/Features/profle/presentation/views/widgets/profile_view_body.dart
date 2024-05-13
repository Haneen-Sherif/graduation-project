import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/profle/data/models/farm_owner_model.dart';
import 'package:graduation_project/Features/profle/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/custom_profile_text_form_field.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.id});
  final String id;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController nameController;

  late TextEditingController phoneNumberController;
  bool isLoading = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();

    phoneNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();

    phoneNumberController.dispose();

    super.dispose();
  }

  final picker = ImagePicker();
  File? img;

  Future<void> pickImage() async {
    print('Attempting to pick an image...');
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        img = File(pickedFile.path);
        print('Image picked: ${img!.path}');
      });
    } else {
      print('No image picked');
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bool emailValid = true;
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<FarmOwnerModel>(
        future: profileCubit.getFarmOwner(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final farmOwner = snapshot.data!;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      color: Color(0xff57ACB5),
                      child: Stack(clipBehavior: Clip.none, children: [
                        Positioned(
                          bottom: -40,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff57ACB5),
                            radius: size.width * 0.18,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.30),
                              child: img == null
                                  ? Image.network(
                                      farmOwner.personalPhoto!,
                                      fit: BoxFit.cover,
                                      width: size.width * 0.30,
                                      height: size.width * 0.30,
                                    )
                                  : Image.file(
                                      img!,
                                      fit: BoxFit.cover,
                                      width: size.width * 0.30,
                                      height: size.width * 0.30,
                                    ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: -30,
                        //   left: 0,
                        //   right: -60,
                        //   child: CircleAvatar(
                        //     radius: 16,
                        //     backgroundColor: Colors.black.withOpacity(0.5),
                        //     child: IconButton(
                        //       onPressed: () async {
                        //         pickImage();
                        //         if (img != null) {
                        //           await profileCubit.updatePersonalPhoto(
                        //             widget.id,
                        //             img ?? File(farmOwner.personalPhoto!),
                        //           );

                        //           print("img: $img");
                        //         }
                        //       },
                        //       icon: Icon(
                        //         Icons.edit,
                        //         size: 16,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 21, right: 21),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomForgotPasswordBackIcon(
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return new AlertDialog(
                                        title: new Text("Delete Account"),
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        surfaceTintColor: Colors.white,
                                        content: new Text(
                                            "Are you sure you want to delete account ?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              try {
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .deleteAccount(widget.id);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                    content: Text(
                                                        'Account deleted successfully'),
                                                  ),
                                                );
                                                context.pop();
                                                context.pushReplacement(
                                                    AppRoutes.kSignInView);
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(Assets.iconsDeleteAccount),
                              ),
                              IconButton(
                                onPressed: () async {
                                  pickImage();
                                  if (img != null) {
                                    await profileCubit.updatePersonalPhoto(
                                      widget.id,
                                      img ?? File(farmOwner.personalPhoto!),
                                    );

                                    print("img: $img");
                                  }
                                  //else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content:
                                  //           Text('Please pick an image first'),
                                  //     ),
                                  //   );
                                  // }
                                  // if (img != null) {
                                  //   BlocProvider.of<ProfileCubit>(context)
                                  //       .updatePersonalPhoto(
                                  //     widget.id,
                                  //     img,
                                  //   );
                                  //   print(img);
                                  // }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          BlocListener<ProfileCubit, ProfileState>(
                              listener: (context, state) {
                                if (state is ProfileLoading) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                                if (state is UpdateSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Updated successfully"),
                                      backgroundColor: kPrimaryColor,
                                    ),
                                  );
                                } else if (state is ProfileFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                }
                              },
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User Name",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    CustomProfileTextFormField(
                                      size: size,
                                      controller: nameController,
                                      hintText: farmOwner.userName!,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Email",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    CustomProfileTextFormField(
                                      size: size,
                                      controller: emailController,
                                      hintText: farmOwner.email!,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email address must not be empty';
                                        } else if (emailValid !=
                                            RegExp(r"^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9]+\.)?[a-zA-Z0-9]+\.[a-zA-Z]+(?:\.com)?$")
                                                .hasMatch(value)) {
                                          return 'Email is invalid';
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Phone Number",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    CustomProfileTextFormField(
                                      size: size,
                                      controller: phoneNumberController,
                                      hintText: farmOwner.phoneNumber!,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Password",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.push(
                                            AppRoutes.kChangePasswordView,
                                            extra: widget.id);
                                      },
                                      child: CustomProfileTextFormField(
                                        suffixIcon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        enabled: false,
                                        size: size,
                                        controller: passwordController,
                                        hintText: "********",
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 74,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: CustomButton(
                                        width: size.width * 0.4,
                                        text: "Save",
                                        onPressed: () {
                                          String? newName =
                                              nameController.text == ''
                                                  ? farmOwner.userName
                                                  : nameController.text;
                                          String? newEmail =
                                              emailController.text == ''
                                                  ? farmOwner.email
                                                  : emailController.text;
                                          String? newPhone =
                                              phoneNumberController.text == ''
                                                  ? farmOwner.phoneNumber
                                                  : phoneNumberController.text;

                                          if (img != null) {
                                            profileCubit.updatePersonalPhoto(
                                              widget.id,
                                              img ??
                                                  File(
                                                      farmOwner.personalPhoto!),
                                            );

                                            print("img: $img");
                                          } else if (newName !=
                                                  farmOwner.userName ||
                                              newEmail != farmOwner.email ||
                                              newPhone !=
                                                  farmOwner.phoneNumber) {
                                            BlocProvider.of<ProfileCubit>(
                                                    context)
                                                .updateFarmOwner(
                                                    widget.id,
                                                    "2024-04-28T06:05:11.217Z",
                                                    newEmail,
                                                    newName,
                                                    newPhone,
                                                    "cairo",
                                                    "cairo");
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "There are no changes to update"),
                                            ));
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 37,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
