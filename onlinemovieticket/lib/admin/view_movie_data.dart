import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieticket/admin/view_detail_movie.dart';
import 'package:onlinemovieticket/admin/view_booked_ticket_data.dart';
import 'package:onlinemovieticket/admin/view_particular_booked_ticket_form.dart';
import 'package:onlinemovieticket/admin/view_particular_movie_data_form.dart';
import 'package:onlinemovieticket/admin/view_particular_passed_out_show_form.dart';
import 'package:onlinemovieticket/admin/view_particular_upcoming_show_form.dart';
import 'package:onlinemovieticket/admin/view_passed_out_show.dart';
import 'package:onlinemovieticket/admin/view_upcoming_show.dart';

import 'admin_home.dart';
import 'insert_movie_data.dart';
import 'insert_passed_out_show.dart';
import 'insert_upcoming_show.dart';

class view_movie_data extends StatefulWidget {
  const view_movie_data({Key? key}) : super(key: key);

  @override
  State<view_movie_data> createState() => _view_movie_dataState();
}

class _view_movie_dataState extends State<view_movie_data> {
  //create an instance of movies
  final CollectionReference viewmovie = FirebaseFirestore.instance.collection('movies');


  //delrecord method
  Future<void> delrecord(String id) async{
    await viewmovie.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
    Text('You Have Successfully Delete The Data')));
  }


  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies Data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.pink),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_home()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('Insert Movie Data'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>insert_movie_data()));
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Insert Passed Out Shows Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>insert_passed_out_show()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('Insert Upcoming Shows Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>insert_upcoming_show()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Booked Ticket Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_booked_ticket()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Movie Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_movie_data()));
                // Navigator.pop(context);
              },
            ),


            ListTile(
              title: const Text('View Upcoming Show Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_upcoming_show()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Passed Out Show Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_passed_out_shows()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Particular Booked Ticket Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_particular_booked_ticket_form()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Particular Movie Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_particular_movie_data_form()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Particular Passed Out Show Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_particular_passed_out_show_form()));
                // Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('View Particular Upcoming Show Data'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context)=>view_particular_upcoming_show_form()));
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: viewmovie.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                            //control goes to view_detail_movie
                                view_detail_movie(
                                  documentSnapshot.id,
                                  documentSnapshot["moviename"],
                                  documentSnapshot["releasedate"].toDate().toString(),
                                  documentSnapshot["review"].toString(),
                                  documentSnapshot["totalcollection"].toString(),
                                  documentSnapshot["lastdate"].toDate().toString(),
                                  documentSnapshot["moviecaption"],
                                  documentSnapshot["movieimage"],
                                  documentSnapshot["actor1"],
                                  documentSnapshot["actor2"],
                                  documentSnapshot["actor3"],
                                  documentSnapshot["director"],
                                  documentSnapshot["singer"],
                                  documentSnapshot["producer"],
                                  documentSnapshot["composer"],
                                  documentSnapshot["actor1caption"],
                                  documentSnapshot["actor1image"],
                                  documentSnapshot["actor2caption"],
                                  documentSnapshot["actor2image"],
                                  documentSnapshot["actor3caption"],
                                  documentSnapshot["actor3image"],

                                )));
                          },

                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                documentSnapshot["movieimage"]
                              // movie.imageUrl
                            ),
                          ),
                          title: Text(
                            documentSnapshot["moviename"], style: TextStyle(
                              color: Colors.pink),),
                          subtitle: Text(
                            documentSnapshot["review"].toString(), style: TextStyle(
                              color: Colors.pinkAccent),),
                        ),
                        ListTile(
                          title: Text("Total Collection : ",
                              style: TextStyle(color: Colors.pink)
                          ),
                          subtitle: Text(
                            documentSnapshot["totalcollection"].toString(),
                            style: TextStyle(
                                color: Colors.pinkAccent.withOpacity(0.6)),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                                CupertinoIcons.delete, color: Colors.pink),
                            onPressed: () {
                              //call delrecord
                              delrecord(documentSnapshot.id);
                            },),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );

        }
      )
    );
  }
}
