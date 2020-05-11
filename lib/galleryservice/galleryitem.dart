import 'package:flutter/widgets.dart';

class GalleryItem {
  GalleryItem({this.id, this.resource, this.isSvg = false});

  final String id;
  final String resource;
  final bool isSvg;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail(
      {Key key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.id,
          child: Image.asset(galleryExampleItem.resource, height: 80.0),
        ),
      ),
    );
  }
}

List<GalleryItem> galleryItems = <GalleryItem>[
  GalleryItem(
    id: "tag1",
    resource: 'images/b2.jpeg',
  ),
  GalleryItem(
    id: "tag2",
    resource: 'images/b3.jpeg',
  ),
  GalleryItem(
    id: "tag3",
    resource: 'images/b4.jpeg',
  ),
  GalleryItem(
    id: "tag4",
    resource: 'images/b5.jpeg',
  ),
  GalleryItem(
    id: "tag5",
    resource: 'images/b1.jpeg',
  ),
  GalleryItem(
    id: "tag6",
    resource: 'images/b2.jpeg',
  ),
  GalleryItem(
    id: "tag7",
    resource: 'images/b3.jpeg',
  ),
  GalleryItem(
    id: "tag8",
    resource: 'images/b4.jpeg',
  ),
  GalleryItem(
    id: "tag9",
    resource: 'images/b5.jpeg',
  ),
  GalleryItem(
    id: "tag10",
    resource: 'images/b1.jpeg',
  ),
];