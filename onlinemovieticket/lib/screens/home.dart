import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieticket/screens/view_detail_movie1.dart';
import 'package:onlinemovieticket/screens/view_status_form.dart';
import '../pages/login_screen.dart';

//create statefull widget HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//When User Is Valid In Login Page It Will Redirect To This Page
class _HomeScreenState extends State<HomeScreen> {

  //create collection refrence with movie collection with firebase
  final CollectionReference viewmovie = FirebaseFirestore.instance.collection('movies');

  //signout Method
  signOut() async {
    Navigator.pushReplacement(
      //control goes to login page
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size * 1.23;

    return Scaffold(
        appBar: AppBar(title: Text("Movies Data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.pink,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: '',
                onPressed: () {
                  //call signout method
                  signOut();
                },
              ),

            ]),
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
                  //control goes to HomeScreen
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  // Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('View Status'),
                onTap: () {
                  //control goes to view_status_form
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>view_status_form()));
                  // Navigator.pop(context);
                },
              ),

            ],
          ),
        ),
        body: StreamBuilder(
          //viewmovie.snapshots give all document from collection movies
            stream: viewmovie.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
              //if screenshot has data then it will go futher otherwise circular indicator will be shown to user
              if(streamSnapshot.hasData) {
                return ListView.builder(
                  //streamSnapshot.data!.docs.length give length of document
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  //if user click on ListTile Control Of The Program Goes TO view_detail_movie1 With Given Fields
                                    context, MaterialPageRoute(builder: (context) =>
                                    view_detail_movie1(
                                      //data pass to constructor of view_detail_movie1
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
                              //show all data of movie document in Particular Form

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
