// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieticket/screens/view_shows.dart';

class view_detail_movie1 extends StatefulWidget {

  //declare all variables which Are Use In Constructor
  String movie_name;
  String release_date;
  String review;
  String total_collection;
  String last_date;
  String movie_caption;
  String movie_image;
  String actor1;
  String actor2;
  String actor3;
  String director;
  String singer;
  String producer;
  String composer;
  String actor1_caption;
  String actor1_image;
  String actor2_caption;
  String actor2_image;
  String actor3_caption;
  String actor3_image;
  String id;

  //constructor of view_detail_movie1
  view_detail_movie1(
      //handle all parameters
      this.id,
      this.movie_name,
      this.release_date,
      this.review,
      this.total_collection,
      this.last_date,
      this.movie_caption,
      this.movie_image,
      this.actor1,
      this.actor2,
      this.actor3,
      this.director,
      this.singer,
      this.producer,
      this.composer,
      this.actor1_caption,
      this.actor1_image,
      this.actor2_caption,
      this.actor2_image,
      this.actor3_caption,
      this.actor3_image);

  @override
  State<view_detail_movie1> createState() => _view_detail_movie1State();
}

class _view_detail_movie1State extends State<view_detail_movie1> {
  String id;
  @override
  void initState() {
    //define id with Id Value Of Constructor
    id = widget.id;
    print(id);
  }

  //Create An Instance Of Movies Collection
  final CollectionReference viewmovie =
      FirebaseFirestore.instance.collection('movies');

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size * 1.23;
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Detail Movie Data",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.pink),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //get snapshot of movies document
            stream: viewmovie.doc(id).snapshots(),
            builder: (_, snapshot) {
              //if snapshot has data then it will go ahead otherwise circulator indicator
              if (snapshot.hasData) {
                return ListView.builder(
                  //itemcount is 1 because we want to show only 1 data of movie in detail
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      //documentSnapshot get The Data
                      var documentSnapshot = snapshot.data.data();
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //on click control goes to view_shows with parameter moviename
                                        builder: (context) => view_shows(
                                              documentSnapshot["moviename"],
                                            )));
                              },
                              //give all data of document movie
                              leading: CircleAvatar(
                                backgroundImage:
                                    //we have to make sure that filed name is same As Database Field Name Otherwise It Will Give An Error Of Field Is
                                //not match
                                    NetworkImage(documentSnapshot["movieimage"]
                                        // movie.imageUrl
                                        ),
                              ),
                              title: Text(
                                documentSnapshot["moviename"],
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              subtitle: Text(
                                documentSnapshot["review"].toString(),
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(documentSnapshot["actor1image"]
                                        // movie.imageUrl
                                        ),
                              ),
                              title: Text(
                                documentSnapshot["actor1"],
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(documentSnapshot["actor2image"]
                                        // movie.imageUrl
                                        ),
                              ),
                              title: Text(
                                documentSnapshot["actor2"],
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(documentSnapshot["actor3image"]
                                        // movie.imageUrl
                                        ),
                              ),
                              title: Text(
                                documentSnapshot["actor3"],
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                            ListTile(
                              title: Text("Release Date : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["releasedate"]
                                    .toDate()
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Total Collection : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["totalcollection"].toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Last Date : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["lastdate"]
                                    .toDate()
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Director : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["director"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Singer : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["singer"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Producer : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["producer"],
                                style: TextStyle(
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Composer : ",
                                  style: TextStyle(color: Colors.pink)),
                              subtitle: Text(
                                documentSnapshot["composer"],
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
