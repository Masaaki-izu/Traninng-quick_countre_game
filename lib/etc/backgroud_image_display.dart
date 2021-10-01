import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const String backGroundImageFile ='assets/images/sky_space_image1.jpg';

class BackgroundImageDisplay extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backGroundImageFile),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
