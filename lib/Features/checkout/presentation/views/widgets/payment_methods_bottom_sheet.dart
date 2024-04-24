import 'package:flutter/material.dart';
import 'package:graduation_project/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';

import 'custom_button_bloc_consumer.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 16,
          ),
          CustomButtonBlocConsumer(id: id),
        ],
      ),
    );
  }
}
