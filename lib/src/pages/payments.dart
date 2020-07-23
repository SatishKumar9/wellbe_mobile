// import 'dart:convert';
import 'package:flutter/material.dart';
import '../helper/functions.dart';
// import 'package:http/http.dart';
import 'drawer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _UserPayPageState createState() => _UserPayPageState();
}

class _UserPayPageState extends State<PaymentScreen> {
  void initState() {
    super.initState();
    getUser();
  }

  String phone_no;
  Razorpay _razorpay = Razorpay();
  // _razorpay.clear();
  // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  TextEditingController _amnt = TextEditingController();
  bool do_pmnt = false;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("payment Success");
    print("$response.paymentId, $response.orderId, $response.signature");
    // FlutterToast.showToast(
    //     msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment error");
    // FlutterToast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // FlutterToast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  Future<void> do_payment(amount) async {
    var options = {
      'key': 'rzp_test_mHgfsIrqTeI7rK',
      'amount': (int.tryParse(amount) * 100).toString(),
      'name': 'WellBe Org.',
      'description': 'Donation for a cause',
      'prefill': {'contact': '$phone_no'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  getUser() {
    localRead("phone_no").then((phone) => {
          setState(() {
            print("phone number: $phone");
            phone_no = phone;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Donations",
        ),
      ),
      body: SafeArea(
        child: new Container(
          child: new Form(
            child: new ListView(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text(
                    "Donate Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "The amount you donate will direcly be used to help needy people.",
                    ),
                  ),
                  SizedBox(height: 50.0),
                  new TextFormField(
                    controller: _amnt,
                    validator: (value) {
                      if (value.isEmpty || (int.tryParse(value) == null)) {
                        return "Enter a valid Amount";
                      } else {
                        do_pmnt = true;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Amount",
                      filled: true,
                      errorStyle: TextStyle(),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Padding(padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0), child: Text('₹', style: TextStyle(fontSize: 20.0),)),
                    ),
                  ),
                  new ButtonBar(
                    children: <Widget>[
                      new RaisedButton(
                        child: Text(
                          "Donate now",
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 7.5),
                        highlightColor: Colors.blue,
                        onPressed: () {
                          var amnt = _amnt.text;
                          do_pmnt ? do_payment(amnt) : null;
                        },
                        color: Colors.blue,
                      )
                    ],
                    alignment: MainAxisAlignment.center,
                  ),
                ]),
            autovalidate: true,
          ),
        ),
      ),
    );
  }
}
