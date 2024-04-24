import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:graduation_project/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:graduation_project/Features/checkout/presentation/manger/cubit/payment_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            BlocProvider.of<RatingCubit>(context).subscribe(id);
            context.pop();

            context.pushReplacement(AppRoutes.kHomeView);
            SnackBar snackBar = SnackBar(
                backgroundColor: kPrimaryColor,
                content: Text("You now marked as Subscripted user"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is PaymentFailure) {
            Navigator.of(context).pop();
            SnackBar snackBar = SnackBar(content: Text(state.errMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) => CustomButton(
            width: double.infinity,
            onPressed: () {
              try {
                PaymentIntentInputModel paymentIntentInputModel =
                    PaymentIntentInputModel(
                        amount: "100",
                        currency: "USD",
                        cusomerId: 'cus_OtX3dJoauN8yEF');

                BlocProvider.of<PaymentCubit>(context).makePayment(
                    paymentIntentInputModel: paymentIntentInputModel);
              } catch (e) {
                print(e);
              }
            },
            // isLoading: state is PaymentLoading ? true : false,
            text: "Continue"));
  }
}
