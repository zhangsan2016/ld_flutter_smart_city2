import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DiscreteSetting extends StatelessWidget {
  const DiscreteSetting({
    Key key,
    @required this.head,
    @required this.options,
    @required this.onSelected,
  }) : super(key: key);

  final String head;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // color: Color.fromARGB(255, 107, 145, 214),
     // color: Colors.grey,
      color: Color.fromARGB(255, 100, 149, 237),
      onSelected: onSelected,
      child: Text(
        head,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(26)),
      ),
      itemBuilder: (context) {
        return options
            .map((value) => PopupMenuItem<String>(
                  child: Text(value),
                  value: value,
                ))
            .toList();
      },
    );
  }
}
