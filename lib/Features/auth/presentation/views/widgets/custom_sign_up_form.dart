import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key, required this.width});

  final double width;

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;
  late TextEditingController dateController;
  late TextEditingController professionalInfoController;
  String? userType;

  void signUp(name, email, phone, password, confirmPass, address) async {
    try {
      Response response = await post(
          Uri.parse("https://10.0.2.2:8000/api/Accounts/farmOwner"),
          body: {
            'email': email,
            'userName': name,
            'password': password,
            'confirmPass': confirmPass,
            'phoneNumber': phone,
            'farmAddress': address,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("success");
      } else {
        print("failure");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();
    dateController = TextEditingController();
    professionalInfoController = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String _dateOfBirth;
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: Column(
        children: [
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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.datetime,
                obscureText: false,
                text: "MM/DD/YYYY",
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'date must not be empty';
                //   }
                //   return null;
                // },
                controller: dateController,
                width: widget.width,
                onSaved: (value) => _dateOfBirth = value.toString(),
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
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Personal Photo",
                        style: Styles.textStyle15
                            .copyWith(color: const Color(0xff383838)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = image;
                        });
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Upload Image",
                                textAlign: TextAlign.center,
                                style: Styles.textStyle10.copyWith(
                                  color: const Color(0xFFFFF9F9),
                                  letterSpacing: 1.08,
                                ),
                              ),
                            ),
                          ],
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
                        style: Styles.textStyle15,
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
                        "Expert",
                        style: Styles.textStyle15,
                      )),
                  value: "expert",
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
              try{
                signUp(
                  nameController.text,
                  emailController.text,
                  phoneNumberController.text,
                  passwordController.text,
                  confirmPasswordController.text,
                  professionalInfoController.text,
                );
              }catch(e){
                print(e);
              }
              // if (formKey.currentState!.validate()) {
              //   formKey.currentState!.save();
              //
              //   // context.pushReplacement(AppRoutes.kSignInView);
              // }
            },
          ),
        ],
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

  ImageProvider getImage() {
    return FileImage(File(image!.path));
  }
}
