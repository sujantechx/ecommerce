import 'package:flutter/material.dart';

class AppColorList extends StatefulWidget {
  List<Color> mColors;
  int selectedColorIndex;
  double size;
  bool fullWidth;

  AppColorList({required this.mColors, required this.selectedColorIndex, required this.size, this.fullWidth = true});

  @override
  State<AppColorList> createState() => _AppColorListState();
}

class _AppColorListState extends State<AppColorList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: widget.fullWidth ? _myList(length: widget.mColors.length) : widget.mColors.length>4 ?  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _myList(length: 3),
          Container(
            margin: const EdgeInsets.all(2),
            width: widget.size-2,
            height: widget.size-2,
            decoration: _colorBallDecor(borderColor: Colors.black54),
            child: Center(
              child: Text("+${widget.mColors.length-3}", style: const TextStyle(fontSize: 9, color: Colors.black54),),
            ),
          )
        ],
      ) : _myList(length: widget.mColors.length>4 ? 4 : widget.mColors.length),
    );
  }

  Widget _myList({required int length}){
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: length,
      itemBuilder: (_, index){
        return InkWell(
          onTap: (){
            widget.selectedColorIndex = index;
            setState(() {

            });
          },
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: _colorBallDecor(borderColor: widget.selectedColorIndex == index ? widget.mColors[index] : Colors.transparent),
            child: Container(
              margin: EdgeInsets.all(widget.size/12),
              width: widget.size-2,
              height: widget.size-2,
              decoration: _colorBallDecor(bgColor: widget.mColors[index]),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _colorBallDecor({Color bgColor = Colors.transparent, Color borderColor = Colors.transparent}){
    return BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(
          color: borderColor,
          width: 1,
        )
    );
  }
}