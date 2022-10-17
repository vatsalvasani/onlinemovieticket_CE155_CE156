import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieticket/screens/bookingform.dart';

//create a stateful widget for view_shows
class view_shows extends StatefulWidget {
  String moviename;

  //Create a Constructor For view_shows Which Take One Parameter Moviename
  view_shows(this.moviename);

  @override
  State<view_shows> createState() => _view_showsState();
}

class _view_showsState extends State<view_shows> {
  //create an instance of upcoming_show
  final CollectionReference upcoming =
      FirebaseFirestore.instance.collection('upcoming_show');

  @override
  Widget build(BuildContext context) {

    //Create Query Show That It Will Only Give Those Value Which Moviename is same as moviename we get in constructor
    //and whenever it shows the data it should be in ascending order of date
    Query nameQuery = upcoming
        .where('moviename', isEqualTo: widget.moviename)
        .orderBy('date', descending: false);

    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Upcoming Show",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.pink),
        body: StreamBuilder(
          //get snapshots from namequery
            stream: nameQuery.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              //for crating an index for fast execution of query
              print(streamSnapshot);
              //if streamSnapshot has data If it's null then also it will go ahead but if there is an error Circular indicator will be shown to user
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  //streamSnapshot.data!.docs.length give an length of document
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
                                        builder: (context) => bookingform(
                                          //when user click on Tiles Control Goes To Booking Form With Given Parameter.
                                              documentSnapshot.id,
                                              documentSnapshot["moviename"],
                                              documentSnapshot["screenno"]
                                                  .toString(),
                                              documentSnapshot["price"]
                                                  .toString(),
                                              documentSnapshot["timing"],
                                              documentSnapshot["date"]
                                                  .toDate()
                                                  .toString(),
                                              documentSnapshot["bookedseats"]
                                                  .toString(),
                                              documentSnapshot["cinema"],
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
                              title: Text("Timing : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["timing"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
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
                            ),
                            ListTile(
                              title: Text("Cinema : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["cinema"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
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
