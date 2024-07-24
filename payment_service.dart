import 'package:stripe_payment/stripe_payment.dart';

class PaymentService {
  PaymentService() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: "your_publishable_key", // Add your Stripe publishable key here
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );
  }

  Future<void> makePayment() async {
    final PaymentMethod paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    );

    // Handle the payment method received from Stripe
    // You can create a PaymentIntent on your server and confirm the payment here
  }
}
