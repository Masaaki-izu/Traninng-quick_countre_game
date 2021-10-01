import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyCustomOutlineButton extends HookWidget {
  final String? textDisplay;
  final VoidCallback? onCallback;
  final Color? colorDisplay;
  final double? width;
  final double? fontSizeChar;
  final String? fontFamilyChar;

  const MyCustomOutlineButton(
      {Key? key,
      this.textDisplay,
      this.onCallback,
      this.colorDisplay,
      this.width,
      this.fontSizeChar,
      this.fontFamilyChar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1.0),
        color: colorDisplay,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(2.0),
      child: RawMaterialButton(
        //fillColor: colorDisplay,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              textDisplay!,
              style: TextStyle(
                  fontFamily: fontFamilyChar,
                  color: Colors.white,
                  fontSize: fontSizeChar),
            ),
          ),
        ),
        onPressed: onCallback,
      ),
    );
  }
}
