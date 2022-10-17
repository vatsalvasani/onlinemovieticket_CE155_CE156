//@dart=2.9
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//create one stateful widget For report
class report extends StatefulWidget {
  //define All The Nessary Variables
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

  //create an constructor for report class
  report(this.movie_name,this.release_date,this.review,this.total_collection,this.last_date,this.movie_caption,this.movie_image,this.actor1, this.actor2,this.actor3,this.director,this.singer,this.producer,this.composer,this.actor1_caption,this.actor1_image,this.actor2_caption,this.actor2_image,this.actor3_caption,this.actor3_image);
  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {

  //create a variable pdf
  final pdf = pw.Document();
  String movie_name;
  String release_date;
  String review;
  String total_collection;
  String last_date;
  String actor1;
  String actor2;
  String actor3;
  String director;
  String singer;
  String producer;
  String composer;

  @override
  void initState() {
    setState(() {
      //set the state of all variables
      movie_name = widget.movie_name;
      release_date = widget.release_date;
      review = widget.review;
      total_collection = widget.total_collection;
      last_date = widget.last_date;
      actor1 = widget.actor1;
      actor2 = widget.actor2;
      actor3 = widget.actor3;
      director = widget.director;
      singer = widget.singer;
      producer = widget.producer;
      composer = widget.composer;
    });

    super.initState();
  }

  //here it shows that how it should look like.
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      canChangeOrientation: false,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    //assign two fonts
    final font1 = await PdfGoogleFonts.aBeeZeeRegular();
    final font2 = await PdfGoogleFonts.abelRegular();
    String _logo = await rootBundle.loadString('assets/icons/splash_icon.svg');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Flexible(
                    child: pw.SvgImage(
                      svg: _logo,
                      height: 10,
                    ),
                  ),
                  pw.SizedBox(
                    height: 0,
                  ),
                  pw.Center(
                    child: pw.Text(
                      'Final Report Of Movie',
                      style: pw.TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    height: 30,
                  ),
                  pw.Divider(),
                  pw.Padding(padding: pw.EdgeInsets.all(40)),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Movie Name : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        movie_name,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Release date : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        release_date,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Review : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        review,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Total Collection : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        total_collection,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Last Date : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        last_date,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Actor1 : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        actor1,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Actor2 : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        actor2,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Actor3 : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        actor3,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Director : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        director,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Singer : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        singer,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Producer : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        producer,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Composer : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        composer,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),


                ],
              ));
        },
      ),
    );

    return doc.save();
  }
}