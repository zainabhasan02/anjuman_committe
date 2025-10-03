import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../utils/utils.dart';

class RazorPaymentScreen extends StatefulWidget {
  const RazorPaymentScreen({super.key});

  @override
  State<RazorPaymentScreen> createState() => _RazorPaymentScreenState();
}

class _RazorPaymentScreenState extends State<RazorPaymentScreen> {
  late Razorpay _razorpay;
  RxString paymentID = ''.obs;
  int amount = 50000; // ₹500

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    // Event Listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // memory clean
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_gTFK8sRryOdQ7Y', // Razorpay API Key
      'amount': amount, // amount in paise (50000 = ₹500)
      'name': 'app_title'.tr,
      'description': 'Test Payment',
      'prefill': {'contact': '9876543210', 'email': 'test@razorpay.com'},
      /*'external': {
        'wallets': ['paytm'],
      },*/
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: ${response.paymentId}");
    paymentID.value = response.paymentId!;
    Utils.snackBarBottom(
      'Razor Payment Success',
      "Payment Successful: ${response.paymentId!}",
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.code} - ${response.message}");
    Utils.snackBarBottom('Razor Payment Error', 'Payment Failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: ${response.walletName}");
    Utils.snackBarBottom(
      'Razor Payment Wallet',
      "External Wallet: ${response.walletName}",
    );
  }

  @override
  Widget build(BuildContext context) {
    print('paymentID outside: $paymentID');
    return Scaffold(
      appBar: customGradientAppBar(title: 'razorpay_payment'.tr),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show Payment ID & Amount only if payment is successful
            Obx(() {
              if (paymentID.value.isEmpty) return SizedBox.shrink();
                return Text(
                  '${'payment_id'.tr}: ${paymentID.value ?? ''}\n${'amount'.tr}: ₹${amount ~/ 100}', // converting paisa -> ₹
                  style: mTextStyle16(),
                );
            }),
            SizedBox(height: 15),
            MRoundedButton(
              width: 150,
              btnName: 'pay_now'.tr,
              onPressed: () => openCheckout(),
            ),
          ],
        ),
      ),
    );
  }
}
