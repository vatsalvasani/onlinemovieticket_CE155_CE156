import 'package:flutter/material.dart';
import 'package:onlinemovieticket/screens/cinema_seat.dart';
import 'package:onlinemovieticket/const.dart';
import 'package:onlinemovieticket/screens/payment.dart';

class BuyTicket extends StatelessWidget {
  final title;

  const BuyTicket(this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .12,
                    height: MediaQuery.of(context).size.width * .12,
                    decoration: kRoundedFadedBorder,
                    child: IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 28.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Colors.pinkAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0.0),
              width: MediaQuery.of(context).size.width * .9,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.tv,
                    color: kPimaryColor,
                    size: 25.0,
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Rajhans cineplex', style: kMainTextStyle),
                        const Text(
                            'Pal Hazira ,RahulRaj Mall, Citylight ,Surat ',
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 18.0)),
                        const SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            Text('2D', style: kMainTextStyle),
                            const SizedBox(width: 10.0),
                            const Text('3D',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // const Icon(
                  //   Icons.keyboard_arrow_right,
                  //   size: 30.0,
                  //   color: Colors.white38,
                  // )
                ],
              ),
            ),
            Center(child: Image.asset('assets/images/screen.png')),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // First Seat Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20),
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20),
                      ),
                    ],
                  ),
                  // Second Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(
                        isReserved: true,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                    ],
                  ),
                  // Third  Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(),
                      CienmaSeat(
                        isReserved: true,
                      ),
                      CienmaSeat(
                        isReserved: true,
                      ),
                    ],
                  ),
                  // 4TH Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(
                        isReserved: true,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                    ],
                  ),
                  // 5TH Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                    ],
                  ),
                  // 6TH Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                    ],
                  ),
                  // final Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20),
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20) * 2,
                      ),
                      CienmaSeat(),
                      CienmaSeat(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25.0))),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PayMaterialApp()));
                        },
                        child: Text('Pay',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
