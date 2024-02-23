import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class DeviceSize {
  final Size size;
  final double width;
  final double height;
  final double aspectRatio;
  late bool isTablet;
  late bool isPhone;
  
  DeviceSize({
    required this.size,
    required this.width,
    required this.height,
    required this.aspectRatio,
    this.isTablet = false,
    this.isPhone = false});

  static DeviceSize create(BuildContext context) {
     DeviceSize deviceSize = DeviceSize(
        size: MediaQuery.of(context).size,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        isTablet: Device.get().isTablet,
        isPhone: Device.get().isPhone);
    return deviceSize;
  }
}