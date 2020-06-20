import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotlinproject/global/constant/color_const.dart';
import 'package:kotlinproject/global/utils/widget_helper.dart';

Widget bgDesign() {
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 150,
          width: 150,
          transform: Matrix4.translationValues(-50, -50, 0.0),
          decoration: BoxDecoration(
              color: ColorConst.CIRCLE_FADE1, shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 200,
          width: 200,
          transform: Matrix4.translationValues(-50, -100, 0.0),
          decoration: BoxDecoration(
              color: ColorConst.CIRCLE_FADE1, shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 150,
          width: 150,
          transform: Matrix4.translationValues(50, 50, 0.0),
          decoration: BoxDecoration(
              color: ColorConst.CIRCLE_FADE1, shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 150,
          width: 150,
          transform: Matrix4.translationValues(50, 150, 0),
          decoration: BoxDecoration(
              color: ColorConst.CIRCLE_FADE1, shape: BoxShape.circle),
        ),
      ),
    ],
  );
}

Widget searchCountry(TextEditingController controller) => Padding(
  padding:
  const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 2.0, right: 8.0),
  child: Card(
    child: TextFormField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Search your country',
          contentPadding: const EdgeInsets.only(
              left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
          border: InputBorder.none),
    ),
  ),
);

Widget dummyRaisedBtn(String txt, Color btnColor) {
  return ButtonTheme(
    minWidth: double.infinity,
    height: 45,
    child: RaisedButton(
      color: btnColor,
      child: getTxtWhiteColor(msg:txt, fontSize: 15,fontWeight: FontWeight.bold),
      onPressed: () {},
    ),
  );
}



