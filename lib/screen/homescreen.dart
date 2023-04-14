import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}
class _homescreenState extends State<homescreen> {
  TextEditingController _amount=TextEditingController();



 void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
   // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){

    print(response.paymentId.toString());
    //api
    //firebase
    //thank you
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
   /// showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
   // showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }


// merchant id: LWQGSCZkpIN5fK

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Payment"),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
             color: Colors.black))),
            controller: _amount,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(onPressed: (){
            var amount=_amount.text.toString();

                  Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_hdkvBuBbG18tVE',
                    'amount': double.parse(amount) * 100,
                    'name': 'online shopping',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  razorpay.open(options);

          }, child: Text("Pay"))
      ]),
    );
  }
}