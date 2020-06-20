import 'package:flutter/material.dart';
import 'package:kotlinproject/global/constant/assets_const.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: AssetsConst.ONBORD1,
    title: 'A Cool Way to Get Start',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: AssetsConst.ONBORD2,//'assets/images/image2.jpg',
    title: 'Design Interactive App UI',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: AssetsConst.ONBORD3,//'assets/images/image3.jpg',
    title: 'It\'s Just the Beginning',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: AssetsConst.ONBORD4,//'assets/images/image3.jpg',
    title: 'A Cool Way to Get Start',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];
