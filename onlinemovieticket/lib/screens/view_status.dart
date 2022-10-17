import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class view_status extends StatefulWidget {
  // const view_shows({Key? key}) : super(key: key);

  String c_name;
  String date1;
  view_status(this.c_name,this.date1){

  }

  @override
  State<view_status> createState() => _view_statusState();
}

class _view_statusState extends State<view_status> {

  final CollectionReference status = FirebaseFirestore.instance.collection('booked_ticket');

  Future<void> delrecord(String id) async {
    await status.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
    Text('You Have Successfully Cancel Your Booking Refund Will Given To You After Some Processing Time.')));
  }


  @override
  Widget build(BuildContext context) {
    Query readQuery = status
        .where('date',isGreaterThanOrEqualTo: DateTime.parse(widget.date1))
        .where("c_name",isEqualTo: widget.c_name);

    final Size _size = MediaQuery.of(context).size * 1.23;
    return Scaffold(
        appBar: AppBar(title: Text("Booked Ticket Data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.pink),
        body: StreamBuilder(
            stream:  readQuery.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
              print(streamSnapshot);
              if(streamSnapshot.hasData) {
                print(streamSnapshot.data!.docs.length);
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context,index)
                    {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Icon(CupertinoIcons.person,color:Colors.pinkAccent),
                              title: Text(documentSnapshot["c_name"],
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["m_name"],
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Date : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["date"].toDate().toString(),
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              title: Text("Price : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["price"].toString(),
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),

                            ListTile(
                              title: Text("Timing : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["timing"],
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),

                            ListTile(
                              title: Text("Seat Numbers : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["seatno"],
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),

                            ListTile(
                              title: Text("Cinema : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["cinema"],
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),
                            ),

                            ListTile(
                              title: Text("No. Of Seats : ",
                                  style: TextStyle(color: Colors.pink)
                              ),
                              subtitle: Text(
                                documentSnapshot["no_of_seats"].toString(),
                                style: TextStyle(color: Colors.pinkAccent.withOpacity(0.6)),
                              ),

                              trailing: IconButton(
                                icon : Icon(CupertinoIcons.delete,color: Colors.pink),
                                onPressed: (){
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
