//@dart=2.9
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//create one stateful widget For report
class report_bookticket extends StatefulWidget {
  //define All The Nessary Variables

  String c_name;
  String m_name;
  String date;
  String price;
  String timing;
  String screenno;
  String seatno;
  String no_of_seats;
  String cinema;

  //create an constructor for report class
  report_bookticket(this.c_name, this.m_name, this.date, this.price,
      this.timing, this.cinema, this.screenno, this.seatno, this.no_of_seats);
  @override
  State<report_bookticket> createState() => _report_bookticketState();
}

class _report_bookticketState extends State<report_bookticket> {
  //create a variable pdf
  final pdf = pw.Document();
  String c_name;
  String m_name;
  String date;
  String price;
  String timing;
  String screenno;
  String seatno;
  String no_of_seats;
  String cinema;

  @override
  void initState() {
    setState(() {
      //set the state of all variables
      c_name = widget.c_name;
      m_name = widget.m_name;
      date = widget.date;
      price = widget.price;
      timing = widget.timing;
      screenno = widget.screenno;
      seatno = widget.seatno;
      no_of_seats = widget.no_of_seats;
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
                  'Final Report Of Booked Ticket',
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
                    'Customer Name : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    c_name,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(
                    'Movie Name : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    m_name,
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
                    'Seat No. : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    seatno,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(
                    'No. Of Seats : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    no_of_seats,
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
