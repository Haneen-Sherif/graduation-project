import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key, required this.width});

  final double width;

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  final ImagePicker picker = ImagePicker();
  File? img;
  File? img2;
  String? imgValidationError;
  String? imgValidationError2;

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = pickedFile != null ? File(pickedFile.path) : null;
      imgValidationError = null;
    });
  }

  Future pickImage2() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      img2 = pickedFile != null ? File(pickedFile.path) : null;
      imgValidationError2 = null;
    });
  }

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool isLoading = false;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;
  late TextEditingController dateController;
  late TextEditingController professionalInfoController;
  late TextEditingController addressController;
  String? userType;

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();
    dateController = TextEditingController();
    professionalInfoController = TextEditingController();
    addressController = TextEditingController();

    userType = "farm_owner";

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    professionalInfoController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final bool emailValid = true;
    final bool digitRegex = true;
    final bool upperRegex = true;
    final bool nonAlphanumericRegex = true;
    String _dateOfBirth;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          context.pushReplacement(AppRoutes.kSignInView);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: Column(
          children: [
            if (isLoading) CircularProgressIndicator(),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
              text: "Name",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name must not be empty';
                }
                return null;
              },
              controller: nameController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              text: "Email",
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
              controller: emailController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              obscureText: false,
              text: "Phone Number",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone number must not be empty';
                }
                return null;
              },
              controller: phoneNumberController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
              text: "Address",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address must not be empty';
                }
                return null;
              },
              controller: addressController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: passwordVisible
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.black.withOpacity(0.6),
                      )
                    : Icon(Icons.visibility_off_outlined,
                        color: Colors.black.withOpacity(0.6)),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              obscureText: passwordVisible,
              text: "Password",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password must not be empty';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters.';
                } else if (upperRegex != RegExp(r'.*[A-Z].*').hasMatch(value)) {
                  return "Password must have at least one uppercase ('A'-'Z').";
                } else if (digitRegex != RegExp(r'.*[0-9].*').hasMatch(value)) {
                  return "Password must have at least one digit ('0'-'9').";
                } else if (nonAlphanumericRegex !=
                    RegExp(r'.*[^a-zA-Z0-9].*').hasMatch(value)) {
                  return "Password must have at least one special character.";
                }
                return null;
              },
              controller: passwordController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                },
                icon: confirmPasswordVisible
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.black.withOpacity(0.6),
                      )
                    : Icon(Icons.visibility_off_outlined,
                        color: Colors.black.withOpacity(0.6)),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              obscureText: confirmPasswordVisible,
              text: "Confirm Password",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Confirm password must not be empty';
                }
                if (passwordController.text != confirmPasswordController.text) {
                  return "Please make sure your passwords match";
                }
                return null;
              },
              controller: confirmPasswordController,
              width: widget.width,
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: userType == "specialist"
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.datetime,
                              obscureText: false,
                              text: "MM/DD/YYYY",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                                return null;
                              },
                              controller: dateController,
                              width: widget.width,
                              onSaved: (value) =>
                                  _dateOfBirth = value.toString(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          text: "Professional Information",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Professional information must not be empty';
                            }
                            return null;
                          },
                          controller: professionalInfoController,
                          width: widget.width,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Personal Photo",
                                          style: Styles.textStyle14(context)
                                              .copyWith(
                                                  color:
                                                      const Color(0xff383838)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    pickImage();
                                  },
                                  child: Container(
                                    height: 25,
                                    decoration: ShapeDecoration(
                                      color: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              "Upload",
                                              textAlign: TextAlign.center,
                                              style: Styles.textStyle10(context)
                                                  .copyWith(
                                                color: const Color(0xFFFFF9F9),
                                                letterSpacing: 1.08,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "Graduation Certificate",
                                          style: Styles.textStyle14(context)
                                              .copyWith(
                                                  color:
                                                      const Color(0xff383838)),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: SizedBox())
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    pickImage2();
                                  },
                                  child: Container(
                                    height: 25,
                                    decoration: ShapeDecoration(
                                      color: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              "Upload",
                                              textAlign: TextAlign.center,
                                              style: Styles.textStyle10(context)
                                                  .copyWith(
                                                color: const Color(0xFFFFF9F9),
                                                letterSpacing: 1.08,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.black,
                    title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Farm Owner",
                          style: Styles.textStyle15(context),
                        )),
                    value: "farm_owner",
                    groupValue: userType,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (value) {
                      setState(() {
                        userType = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.black,
                    title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Specialist",
                          style: Styles.textStyle15(context),
                        )),
                    value: "specialist",
                    groupValue: userType,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (value) {
                      setState(() {
                        userType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            CustomButton(
              width: widget.width,
              text: "Sign Up",
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    userType == "farm_owner") {
                  formKey.currentState!.save();
                  BlocProvider.of<AuthCubit>(context).signUp(
                    nameController.text,
                    emailController.text,
                    phoneNumberController.text,
                    passwordController.text,
                    confirmPasswordController.text,
                    addressController.text,
                  );
                } else if (formKey.currentState!.validate() &&
                    userType == "specialist") {
                  BlocProvider.of<AuthCubit>(context).expertSignUp(
                    nameController.text,
                    emailController.text,
                    phoneNumberController.text,
                    passwordController.text,
                    confirmPasswordController.text,
                    addressController.text,
                    dateController.text,
                    img!,
                    professionalInfoController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    DateFormat formatter = DateFormat('MM/dd/yyyy');
    final DateTime? picked = await showDatePicker(
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
