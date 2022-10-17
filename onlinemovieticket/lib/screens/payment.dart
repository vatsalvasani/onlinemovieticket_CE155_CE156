//first of all add json file in asstes folder
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onlinemovieticket/screens/view_status_form.dart';
import 'package:pay/pay.dart';

import 'home.dart';

void main() {
  runApp(PayMaterialApp());
}

// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '600',
//     status: PaymentItemStatus.final_price,
//   )
// ];

class PayMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('de', ''),
      ],
      home: PaySampleApp(),
    );
  }
}

class PaySampleApp extends StatefulWidget {
  PaySampleApp({Key? key}) : super(key: key);

  @override
  _PaySampleAppState createState() => _PaySampleAppState();
}

class _PaySampleAppState extends State<PaySampleApp> {

  final paymentItems = <PaymentItem> [];

  @override
  void initState(){
    paymentItems.add(PaymentItem(amount:'600',label:"product1",status: PaymentItemStatus.final_price));
    super.initState();
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Your Ticket",style: TextStyle(color: Colors.white),),backgroundColor: Colors.pink,),
        drawer: Drawer(
          width: 400,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    image: DecorationImage(
                        image: AssetImage("slider_banner.png"),
                        fit: BoxFit.cover)
                ),
                child: Text(''),
              ),

              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  // Navigator.pop(context);
                },
              ),


              ListTile(
                title: const Text('View Status'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>view_status_form()));
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      body: Center(
        child: GooglePayButton(
          //google pay button
            paymentConfigurationAsset:'gpay.json',
            paymentItems: paymentItems,
            onPaymentResult: (data){
              print(data);
            },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ));
  }
}