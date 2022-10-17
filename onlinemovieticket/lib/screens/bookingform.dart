import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlinemovieticket/screens/buy_ticket.dart';
import 'package:onlinemovieticket/screens/home.dart';
import 'package:onlinemovieticket/screens/view_status_form.dart';
import 'package:onlinemovieticket/utils/mytheme.dart';

//create a statefulwidget for bookingform
class bookingform extends StatefulWidget {
  String moviename;
  String screenno;
  String price;
  String timing;
  String date;
  String id;
  String bookedseats;
  String cinema;

  //create a constructor for bookingform and get all the value
  bookingform(this.id, this.moviename, this.screenno, this.price, this.timing,
      this.date, this.bookedseats, this.cinema);

  @override
  State<bookingform> createState() => _bookingformState();
}

class _bookingformState extends State<bookingform> {
  var successfull = 1;
  //create an controller for two fields
  TextEditingController c_name = TextEditingController();
  TextEditingController no_of_seats = TextEditingController();

  //insertrecord method
  Future<void> insertrecord() async {

    //create an instance of booked_ticket collection
    final CollectionReference docMovie = FirebaseFirestore.instance.collection('booked_ticket');

    //logic for assigning a seat manually
    String seatno = (int.parse(widget.bookedseats) + 1).toString();
    for (int i = int.parse(seatno) + 1,j = 1; j < int.parse(no_of_seats.text); j++,i++) {
      seatno = seatno + ',' + i.toString();
    }
    try {
      //logic for add the document in collection
      await docMovie.add({
        //initialize all the fields
        "c_name": c_name.text,
        "date": Timestamp.fromDate(DateTime.parse(widget.date)),
        "m_name": widget.moviename,
        "no_of_seats": int.parse(no_of_seats.text),
        "price": int.parse(widget.price),
        "screenno": int.parse(widget.screenno),
        "seatno": seatno,
        "timing": widget.timing,
        "cinema": widget.cinema,
      });

      //logic for adding no_of_seats Into bookedseats
      int seat = int.parse(widget.bookedseats) + int.parse(no_of_seats.text);

      //firebase crate an instance of upcoming show and update the booked seats.
      FirebaseFirestore.instance
          .collection('upcoming_show')
          .doc(widget.id)
          .update({'bookedseats': seat});

      Navigator.push(context,
          //control goes to BuyTicket
          MaterialPageRoute(builder: (context) => BuyTicket(widget.moviename)));
    } catch (e) {
      print(e);
      successfull = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size * 1.0;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
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
                      fit: BoxFit.cover)),
              child: Text(''),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Status'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => view_status_form()));
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: MyTheme.splash,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: _size.height,
          width: _size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/splash_icon.svg"),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: _size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Book Ticket",
                      style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.splash,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: c_name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Customer Name",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: no_of_seats,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter No. Of Seats",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //it will call insertrecord method
                        insertrecord();
                        if (successfull != 1) {
                          //if there is an error it will shows the error in sneckbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Sorry Some Internal Error Is There Try After Some Time!!")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MyTheme.splash,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "INSERT",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
