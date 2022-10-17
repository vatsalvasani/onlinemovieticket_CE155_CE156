//@dart=2.9
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//create one stateful widget For report
class report_upcoming extends StatefulWidget {
  //define All The Nessary Variables
  String moviename;
  String screenno;
  String totalseats;
  String bookedseats;
  String price;
  String timing;
  String date;
  String moviecaption;
  String movieimage;
  String cinema;

  //create an constructor for report class
  report_upcoming(
      this.moviename,
      this.screenno,
      this.totalseats,
      this.bookedseats,
      this.price,
      this.timing,
      this.cinema,
      this.date,
      this.moviecaption,
      this.movieimage);
  @override
  State<report_upcoming> createState() => _report_upcomingState();
}

class _report_upcomingState extends State<report_upcoming> {
  //create a variable pdf
  final pdf = pw.Document();
  String moviename;
  String screenno;
  String totalseats;
  String bookedseats;
  String price;
  String timing;
  String date;
  String moviecaption;
  String cinema;

  @override
  void initState() {
    setState(() {
      //set the state of all variables
      moviename = widget.moviename;
      screenno = widget.screenno;
      totalseats = widget.totalseats;
      bookedseats = widget.bookedseats;
      price = widget.price;
      timing = widget.timing;
      moviecaption = widget.moviecaption;
      date = widget.date;
      cinema = widget.cinema;
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
                      'Final Report Of Upcoming Show',
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
                        moviename,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Screen No. : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        screenno,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Total Seats : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        totalseats,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Booked Seats : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        bookedseats,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Price : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        price,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  pw.Row(
                    children: [
                      pw.Text(
                        'Timing : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        timing,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Movie Caption : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        moviecaption,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Date : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        date,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Cinema : ',
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        cinema,
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
