import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieticket/admin/pdfpassedout.dart';
import 'package:onlinemovieticket/admin/update_passed_out_show.dart';
import 'package:onlinemovieticket/admin/view_booked_ticket_data.dart';
import 'package:onlinemovieticket/admin/view_movie_data.dart';
import 'package:onlinemovieticket/admin/view_particular_booked_ticket_form.dart';
import 'package:onlinemovieticket/admin/view_particular_movie_data_form.dart';
import 'package:onlinemovieticket/admin/view_particular_passed_out_show_form.dart';
import 'package:onlinemovieticket/admin/view_particular_upcoming_show_form.dart';
import 'package:onlinemovieticket/admin/view_upcoming_show.dart';

import 'admin_home.dart';
import 'insert_movie_data.dart';
import 'insert_passed_out_show.dart';
import 'insert_upcoming_show.dart';

class view_passed_out_shows extends StatefulWidget {
  const view_passed_out_shows({Key? key}) : super(key: key);

  @override
  State<view_passed_out_shows> createState() => _view_passed_out_showsState();
}

class _view_passed_out_showsState extends State<view_passed_out_shows> {
  //create an instance of pass_out_show
  final CollectionReference pass_out_show =
      FirebaseFirestore.instance.collection('passed_out_show');

  //selrecoed method
  Future<void> delrecord(String id) async {
    //delete record from passed_out_show update
    await pass_out_show.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You Have Successfully Delete The Data')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Passed Out Shows",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.pink),
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
                      MaterialPageRoute(builder: (context) => admin_home()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Insert Movie Data'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => insert_movie_data()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Insert Passed Out Shows Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => insert_passed_out_show()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Insert Upcoming Shows Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => insert_upcoming_show()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Booked Ticket Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_booked_ticket()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Movie Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_movie_data()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Upcoming Show Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_upcoming_show()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Passed Out Show Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_passed_out_shows()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Particular Booked Ticket Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              view_particular_booked_ticket_form()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Particular Movie Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              view_particular_movie_data_form()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Particular Passed Out Show Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              view_particular_passed_out_show_form()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View Particular Upcoming Show Data'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              view_particular_upcoming_show_form()));
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: pass_out_show.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            update_passed_out_show(
                                              documentSnapshot.id,
                                              documentSnapshot["moviename"],
                                              documentSnapshot["screenno"]
                                                  .toString(),
                                              documentSnapshot["totalseats"]
                                                  .toString(),
                                              documentSnapshot["bookedseats"]
                                                  .toString(),
                                              documentSnapshot["price"]
                                                  .toString(),
                                              documentSnapshot[
                                                      "total_collection"]
                                                  .toString(),
                                              documentSnapshot["timing"],
                                              documentSnapshot["cinema"],
                                              documentSnapshot["moviecaption"],
                                              documentSnapshot["movieimage"],
                                              documentSnapshot["date"]
                                                  .toDate()
                                                  .toString(),
                                            )));
                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(documentSnapshot["movieimage"]
                                        // movie.imageUrl
                                        ),
                              ),
                              title: Text(
                                documentSnapshot["moviename"],
                                style: TextStyle(color: Colors.pink),
                              ),
                              subtitle: Text(
                                documentSnapshot["date"].toDate().toString(),
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                            ),
                            ListTile(
                              title: Text("Screen No. : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["screenno"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Total Seats : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["totalseats"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Booked Seats : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["bookedseats"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Price : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["price"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Total Collection : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["total_collection"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Timing : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["timing"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Cinema : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["cinema"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                              trailing: IconButton(
                                icon: Icon(CupertinoIcons.printer,
                                    color: Colors.pink),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              report_passedout(
                                                documentSnapshot["moviename"],
                                                documentSnapshot["screenno"]
                                                    .toString(),
                                                documentSnapshot["totalseats"]
                                                    .toString(),
                                                documentSnapshot["bookedseats"]
                                                    .toString(),
                                                documentSnapshot["price"]
                                                    .toString(),
                                                documentSnapshot[
                                                        "total_collection"]
                                                    .toString(),
                                                documentSnapshot["timing"],
                                                documentSnapshot["cinema"],
                                                documentSnapshot[
                                                    "moviecaption"],
                                                documentSnapshot["movieimage"],
                                                documentSnapshot["date"]
                                                    .toDate()
                                                    .toString(),
                                              )));
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("Movie Caption : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["moviecaption"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                              trailing: IconButton(
                                icon: Icon(CupertinoIcons.delete,
                                    color: Colors.pink),
                                onPressed: () {
                                  //call delrecord method
                                  delrecord(documentSnapshot.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
