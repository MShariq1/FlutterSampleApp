import 'dart:async';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../core/constant/image_string.dart';

class CachedNetworkImage extends StatefulWidget {
  final String imageUrl;

  const CachedNetworkImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  State<CachedNetworkImage> createState() => _CachedNetworkImageState();
}

class _CachedNetworkImageState extends State<CachedNetworkImage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      precacheImage(NetworkImage(widget.imageUrl), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: widget.imageUrl,
      fit: BoxFit.fill,
      imageErrorBuilder: (_, object, stackTrace) =>
      const Image(image: ImageString.error,height: 24),
    );
  }
}
class CachedAvatarImage extends StatefulWidget {
  final String imageUrl;
  final double dimension;
  final double padding;
  const CachedAvatarImage(this.imageUrl, {Key? key,this.dimension =30,this.padding=4.0}) : super(key: key);

  @override
  State<CachedAvatarImage> createState() => _CachedAvatarImageState();
}

class _CachedAvatarImageState extends State<CachedAvatarImage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      precacheImage(NetworkImage(widget.imageUrl), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.dimension,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const CircleBorder(),
        child: Padding(
          padding:  EdgeInsets.all(widget.padding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.imageUrl,
              fit: BoxFit.fill,
              imageErrorBuilder: (_, object, stackTrace) =>
              const Image(image: ImageString.error,height: 24),
            ),
          ),
        ),
      ),
    );
  }
}