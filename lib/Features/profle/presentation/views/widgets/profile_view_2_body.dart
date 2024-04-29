import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_text_form_field.dart';
import 'package:graduation_project/Features/profle/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/custom_profile_text_form_field.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:intl/intl.dart';

class ProfileView2Body extends StatefulWidget {
  const ProfileView2Body({super.key, required this.id});
  final String id;

  @override
  State<ProfileView2Body> createState() => _ProfileView2BodyState();
}

class _ProfileView2BodyState extends State<ProfileView2Body> {
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController professionalController;

  late TextEditingController phoneNumberController;
  bool isLoading = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    professionalController = TextEditingController();

    phoneNumberController = TextEditingController();
    dateController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    professionalController.dispose();

    phoneNumberController.dispose();
    dateController.dispose();

    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bool emailValid = true;
    DateFormat formatter = DateFormat('MM/dd/yyyy');
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    String _dateOfBirth;
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<ExpertsModel>(
        future: profileCubit.getExpert(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final expert = snapshot.data!;
            String dateString = expert.birthDate!;
            DateTime dateTime = DateTime.parse(dateString);
            DateFormat formatter = DateFormat('MM/dd/yyyy');
            String formattedDate = formatter.format(dateTime);
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
                        // Positioned(
                        //   bottom: -75,
                        //   left: 0,
                        //   right: 0,
                        //   child: CircleAvatar(
                        //     backgroundColor: Color(0xff57ACB5),
                        //     radius: 90,
                        //     child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(153),
                        //         child: Image.network(expert.personalPhoto!)),
                        //   ),
                        // ),
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
                              child: Image.asset(
                                Assets.imagesTeamMember1,
                                fit: BoxFit.cover,
                                width: size.width * 0.30,
                                height: size.width * 0.30,
                              ),
                            ),
                          ),
                        ),
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
                                onPressed: () {},
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
                                      hintText: expert.userName!,
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
                                      hintText: expert.email!,
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
                                      hintText: expert.phoneNumber!,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Birthday",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(
                                        child: CustomProfileTextFormField(
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.datetime,
                                          obscureText: false,
                                          hintText: formattedDate,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'date must not be empty';
                                            }
                                            return null;
                                          },
                                          controller: dateController,
                                          size: size,
                                          onSaved: (value) =>
                                              _dateOfBirth = value.toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Professional information",
                                      style: Styles.textStyle16(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    FeedbackTextFormField(
                                      radius: 5,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 3,
                                      maxLines: 5,
                                      borderFocusColor: kPrimaryColor,
                                      cursorColor: kPrimaryColor,
                                      hintStyle: Styles.textStyle12(context)
                                          .copyWith(
                                              color: Color(0xff858585),
                                              letterSpacing: 0.90,
                                              fontWeight: FontWeight.w500),
                                      borderColor: Color(0xffE9E6E6),
                                      fillColor: Colors.white,
                                      textInputAction: TextInputAction.next,
                                      controller: professionalController,
                                      hintText: expert.moreInfo!,
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
                                                  ? expert.userName
                                                  : nameController.text;
                                          String? newEmail =
                                              emailController.text == ''
                                                  ? expert.email
                                                  : emailController.text;
                                          String? newPhone =
                                              phoneNumberController.text == ''
                                                  ? expert.phoneNumber
                                                  : phoneNumberController.text;

                                          String? newMoreInfo =
                                              professionalController.text == ''
                                                  ? expert.moreInfo
                                                  : professionalController.text;

                                          String? newDate =
                                              dateController.text == ''
                                                  ? expert.birthDate
                                                  : dateController.text;

                                          if (newName != expert.userName ||
                                              newEmail != expert.email ||
                                              newPhone != expert.phoneNumber ||
                                              newMoreInfo != expert.moreInfo ||
                                              newDate != expert.birthDate) {
                                            BlocProvider.of<ProfileCubit>(
                                                    context)
                                                .updateExpert(
                                                    widget.id,
                                                    newDate,
                                                    newEmail,
                                                    newName,
                                                    newPhone,
                                                    newMoreInfo,
                                                    "cairo");

                                            print(widget.id);
                                            print(dateTime);
                                            print(formattedDate);
                                            print(newDate);

                                            print(dateController.text);
                                            print(newMoreInfo);
                                            print(newPhone);
                                            print(newEmail);
                                            print(newName);
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

  Future _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    DateFormat formatter = DateFormat('MM/dd/yyyy');
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor, // header background color
                onPrimary: Colors.black, // header text color
                // onSurface: Colors.green, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: kPrimaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      });
  }
}
