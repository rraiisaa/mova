import 'package:flutter/material.dart';


late MediaQueryData _mediaQueryData;
late double screenWidth;
late double screenHeight;
late double blockSizeHorizontal;
late double blockSizeVertical;

const double designWidth = 375; 
const double designHeight = 812; 

void initSizeConfig(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;

  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
}

double getProportionateScreenWidth(double inputWidth) {
  double proportion = inputWidth / designWidth;
  return proportion * screenWidth;
}

double getProportionateScreenHeight(double inputHeight) {
  double proportion = inputHeight / designHeight;
  return proportion * screenHeight;
}