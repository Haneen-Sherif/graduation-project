import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_text_form_field.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  bool chckVal = false;
  bool privacyPolicyAccepted = false;

  late TextEditingController emailController;
  late TextEditingController nameController;

  late TextEditingController phoneNumberController;

  late TextEditingController messageController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();

    phoneNumberController = TextEditingController();

    messageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();

    phoneNumberController.dispose();

    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final bool emailValid = true;
    final Size size = MediaQuery.sizeOf(context);
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeMessageSuccess) {
          nameController.clear();
          emailController.clear();
          phoneNumberController.clear();
          messageController.clear();
          privacyPolicyAccepted = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kPrimaryColor,
            ),
          );
        } else if (state is HomeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 38,
            vertical: 40,
          ),
          child: Column(
            children: [
              FeedbackTextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty';
                  }
                  return null;
                },
                lebelText: "Name",
              ),
              SizedBox(
                height: 26,
              ),
              FeedbackTextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty';
                  } else if (emailValid !=
                      RegExp(r"^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9]+\.)?[a-zA-Z0-9]+\.[a-zA-Z]+(?:\.com)?$")
                          .hasMatch(value)) {
                    return 'Email is invalid';
                  }
                  return null;
                },
                lebelText: "Email",
              ),
              SizedBox(
                height: 26,
              ),
              FeedbackTextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: phoneNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Telephone Number must not be empty';
                  }
                  return null;
                },
                lebelText: "Telephone Number",
              ),
              SizedBox(
                height: 26,
              ),
              FeedbackTextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                textInputAction: TextInputAction.next,
                controller: messageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Message must not be empty';
                  }
                  return null;
                },
                hintText: "Message",
              ),
              SizedBox(
                height: 14,
              ),
              CheckboxFormField(
                initialValue: privacyPolicyAccepted,
                onChanged: (newValue) {
                  setState(() {
                    privacyPolicyAccepted = newValue ?? false;
                  });
                },
                validator: (value) {
                  if (value != true) {
                    return 'Rquired';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CustomButton(
                    width: size.width * 0.5,
                    text: "Send Message",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        BlocProvider.of<HomeCubit>(context).addFeedback(
                          nameController.text,
                          emailController.text,
                          messageController.text,
                        );
                        print("success");
                      }
                      ;
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    required void Function(bool?)? onChanged,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xffafb0b8),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: Color(0xffafb0b8),
              title: Text(
                "I have read and accept the privacy policy.",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff303030),
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: state.value ?? initialValue,
              onChanged: (newValue) {
                onChanged?.call(newValue); // Call the onChanged callback
              },
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
}
