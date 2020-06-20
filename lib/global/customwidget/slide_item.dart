import 'package:flutter/material.dart';
import 'package:kotlinproject/global/customwidget/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          slideList[index].title,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
          child: Text(
            slideList[index].description,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
