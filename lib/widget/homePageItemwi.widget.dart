import 'package:flutter/material.dart';
class HomePageItem extends StatelessWidget{
  final String imagePath;
  final VoidCallback onTap;
  const HomePageItem({
 required this.imagePath,
 required this.onTap,});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink.image(height: 180,width: 180
          ,image: AssetImage(imagePath),
      ),
      onTap: onTap,
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}