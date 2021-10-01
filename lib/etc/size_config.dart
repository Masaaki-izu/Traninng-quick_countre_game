import 'package:flutter/widgets.dart';
// 画面によって表示サイズ調整
class SizeConfig {
	static MediaQueryData? _mediaQueryData;
	static double? screenWidth;
	static double? screenHeight;
	static double? blockSizeHorizontal;
	static double? blockSizeVertical;
	static double? _safeAreaHorizontal;
	static double? _safeAreaVertical;
	static double? safeBlockHorizontal;
	static double? safeBlockVertical;
	static double? screenAspectRatio;

	void init(BuildContext context) {
		_mediaQueryData = MediaQuery?.of(context);
		screenWidth = _mediaQueryData?.size.width;
		screenHeight = _mediaQueryData?.size.height;
		blockSizeHorizontal = screenWidth! / 100;
		blockSizeVertical = screenHeight! / 100;
		screenAspectRatio = _mediaQueryData?.size.aspectRatio;
		_safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
		_safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
		safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
		safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
	}
}