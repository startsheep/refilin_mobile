import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/models/payment_model.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/payment_method_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class PaymentMethod extends GetView<PaymentMethodController> {
  const PaymentMethod({Key? key, required this.onChange}) : super(key: key);
  final Function(PaymentModel) onChange;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      constraints: const BoxConstraints(
        maxHeight: 500,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.paymentList.length,
        itemBuilder: (context, index) {
          final payment = controller.paymentList[index];
          print(payment.children!.isEmpty);
          return PaymentTile(
            payment: payment,
            onChange: onChange,
          );
        },
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final PaymentModel payment;
  final Function(PaymentModel) onChange;
  PaymentTile({
    Key? key,
    required this.payment,
    required this.onChange,
  }) : super(key: key);
  final PaymentMethodController controller =
      Get.find<PaymentMethodController>();
  @override
  Widget build(BuildContext context) {
    if (payment.children!.isEmpty) {
      return ListTile(
        leading: Image.asset(
          'assets/icon/${payment.logo}',
          width: 30,
          height: 30,
        ),
        title: Text(
          payment.name!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          payment.description!,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        trailing: Obx(
          () => Radio<String?>(
            activeColor: Theme.of(context).primaryColor,
            value: payment.id,
            onChanged: (value) {
              controller.payment.value = payment;
              onChange(payment);
            },
            groupValue: controller.payment.value.id,
          ),
        ),
      );
    } else {
      return ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 20),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.white10,
        iconColor: Theme.of(context).primaryColor,
        collapsedTextColor: Theme.of(context).primaryColor,
        leading: Image.asset(
          'assets/icon/${payment.logo}',
          width: 30,
          height: 30,
        ),
        title: Text(
          payment.name!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ThemeApp.darkColor,
          ),
        ),
        subtitle: Text(
          payment.description!,
          style: TextStyle(
            fontSize: 12,
            color: ThemeApp.darkColor,
          ),
        ),
        children: payment.children!.map((childPayment) {
          return PaymentTile(
            payment: childPayment,
            onChange: onChange,
          );
        }).toList(),
      );
    }
  }
}
