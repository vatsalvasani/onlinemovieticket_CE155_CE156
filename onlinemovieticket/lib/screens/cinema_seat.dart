import 'package:flutter/material.dart';
import 'package:onlinemovieticket/const.dart';

class CienmaSeat extends StatefulWidget {
  bool isReserved;

  bool isSelected;

  CienmaSeat({Key? key, this.isSelected = false, this.isReserved = false}) : super(key: key);

  @override
  _CienmaSeatState createState() => _CienmaSeatState();
}

class _CienmaSeatState extends State<CienmaSeat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          !widget.isReserved ? widget.isSelected = !widget.isSelected : null;
        });
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? Color(0xffF7BB0E)
                  : widget.isReserved ? Colors.pinkAccent : null,
              border: !widget.isSelected && !widget.isReserved
                  ? Border.all(color: Colors.pinkAccent, width: 1.0)
                  : null,
              borderRadius: BorderRadius.circular(5.0))),
    );

  }
}