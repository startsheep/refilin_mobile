import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/payment_model.dart';

class PaymentMethodController extends GetxController {
  final RxList<PaymentModel> paymentList = <PaymentModel>[].obs;
  final Rx<PaymentModel> payment = PaymentModel().obs;
  @override
  void onInit() {
    super.onInit();
    paymentList.addAll(resourcesPayment());
  }

  PaymentModel? findParentPayment(PaymentModel childPayment) {
    for (final payment in paymentList) {
      if (payment.children!.contains(childPayment)) {
        return payment;
      }
    }
    return null;
  }
}
