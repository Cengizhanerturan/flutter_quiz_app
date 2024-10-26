import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/controller/app/controller.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends BaseGetView<AppController> {
  final String? url;
  final double imageHeight;
  final double imageWidth;
  final double iconSize;
  const ProfilePhoto(
      {Key? key,
      required this.url,
      required this.imageHeight,
      required this.imageWidth,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: getImage(),
    );
  }

  Widget getImage() {
    if (url != null && url != '') {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundImage: NetworkImage(
          '${controller.profileImageBaseUrl}$url',
        ),
      );
    } else {
      return Center(
        child: Icon(
          Icons.person_outline_rounded,
          size: iconSize,
          color: theme.canvasColor.withOpacity(.6),
        ),
      );
    }
  }
}
