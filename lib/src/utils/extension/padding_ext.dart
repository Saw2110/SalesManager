import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget pa(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget p([double lp = 0, rp = 0, tp = 0, bp = 0]) {
    return Padding(
      padding: EdgeInsets.only(left: lp, right: rp, top: tp, bottom: bp),
      child: this,
    );
  }

  Widget pt([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget pb([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  Widget pr([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  Widget pl([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  Widget pv([double value = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value, horizontal: 0.0),
      child: this,
    );
  }

  Widget ph([double value = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: value),
      child: this,
    );
  }
}
