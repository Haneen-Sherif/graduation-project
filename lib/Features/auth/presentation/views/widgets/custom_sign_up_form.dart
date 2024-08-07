import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_text_form_field.dart';
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

  bool buttonClicked = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: kPrimaryColor,
            ),
          );
          context.pushReplacement(AppRoutes.kSignInView);
        } else if (state is AuthFailure) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.message),
          //   ),
          // );
        }
      },
      child: Form(
        autovalidateMode:
            buttonClicked ? AutovalidateMode.always : AutovalidateMode.disabled,
        key: formKey,
        child: Column(
          children: [
            if (isLoading)
              CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
              text: "Username",
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
                        FeedbackTextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 5,
                          borderFocusColor: kPrimaryColor,
                          cursorColor: kPrimaryColor,
                          hintStyle: Styles.textStyle14(context).copyWith(
                            color: Colors.black.withOpacity(0.78),
                            letterSpacing: 0.90,
                          ),
                          borderColor: Colors.white,
                          fillColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          controller: professionalInfoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Professional information must not be empty';
                            }
                            return null;
                          },
                          hintText: "Professional Information",
                        ),
                        // CustomTextFormField(
                        //   textInputAction: TextInputAction.next,
                        //   keyboardType: TextInputType.multiline,
                        //   obscureText: false,
                        //   text: "Professional Information",
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Professional information must not be empty';
                        //     }
                        //     return null;
                        //   },
                        //   controller: professionalInfoController,
                        //   width: widget.width,
                        // ),
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
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Personal Photo",
                                          style: Styles.textStyle12(context)
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
                              // const SizedBox(
                              //   width: 4,
                              // ),
                              Expanded(
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
                                    child: FittedBox(
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        imgValidationError != null
                            ? Text(
                                imgValidationError!,
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "Graduation Certificate",
                                          style: Styles.textStyle12(context)
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
                              // const SizedBox(
                              //   width: 4,
                              // ),
                              Expanded(
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
                                    child: FittedBox(
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
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        imgValidationError2 != null
                            ? Text(
                                imgValidationError2!,
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
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
                  flex: 5,
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
                  flex: 4,
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
                setState(() {
                  buttonClicked = true;
                });
                if (formKey.currentState!.validate() &&
                    userType == "farm_owner") {
                  formKey.currentState!.save();
                  BlocProvider.of<AuthCubit>(context).signUp(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    phoneNumberController.text,
                    passwordController.text.trim(),
                    confirmPasswordController.text.trim(),
                    addressController.text.trim(),
                  );
                } else if (formKey.currentState!.validate() &&
                    userType == "specialist") {
                  if (img == null) {
                    setState(() {
                      imgValidationError = 'Please upload your personal photo';
                    });
                  } else if (img2 == null) {
                    setState(() {
                      imgValidationError2 =
                          'Please upload your certificate photo';
                    });
                  } else {
                    BlocProvider.of<AuthCubit>(context).expertSignUp(
                      nameController.text.trim(),
                      emailController.text.trim(),
                      phoneNumberController.text,
                      passwordController.text.trim(),
                      confirmPasswordController.text.trim(),
                      addressController.text.trim(),
                      dateController.text,
                      img!,
                      img2!,
                      professionalInfoController.text.trim(),
                    );
                  }
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
