import 'package:flutter/material.dart';

class LikeClass extends StatefulWidget {
  bool checked;
  Color? color;
  double? size;

  LikeClass(this.checked, this.color, {this.size});

  @override
  _LikeClassState createState() => new _LikeClassState();
}

class _LikeClassState extends State<LikeClass> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (() {
        setState(() {
          widget.checked = !widget.checked;
        });
      }),
      child: new Icon(
        widget.checked ? Icons.favorite : Icons.favorite_border,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
