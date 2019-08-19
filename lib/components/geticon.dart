import 'package:flutter/material.dart';
import 'package:weather/assets/icons/w_icons_icons.dart';

IconData wicon;

IconData getIcon(String weather) {
  if (weather == 'Haze') {
    wicon = WIcons.haze;
  } else if (weather == 'Clouds') {
    wicon = WIcons.clouds;
  } else if (weather == 'Mist') {
    wicon = WIcons.windy;
  } else
    wicon = WIcons.antenna;
  return wicon;
}
