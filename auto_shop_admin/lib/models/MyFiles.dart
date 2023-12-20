import 'package:hostel_finder_admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;

  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,

    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Add Shop",

    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "",
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Bookings",

    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "25 new",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "View Users",

    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "2 new",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "View shops",

    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "",
    color: Color(0xFF007EE5),
  ),
];
