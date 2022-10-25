import 'package:flutter/material.dart';

class MainUserImages extends StatelessWidget {
  final String image;
  final String first_name;
  final String last_name;
  const MainUserImages(this.image, this.first_name, this.last_name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.topCenter,
        ),
        Positioned.fill(
          child: SizedBox(
            width: double.infinity,
            child: this.image == "" ? CircleAvatar(
                minRadius: 150,
              backgroundColor: Color(0xff764abc),
              foregroundColor: Color(0xffffffff),
              child: Text(
                first_name.substring(0,1).toUpperCase() + last_name.substring(0,1).toUpperCase(),
                style: TextStyle(fontSize: 40),
              )
            ) : CircleAvatar(
              radius: 360.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360.0),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Image.network(image.toString()),
                  ),
                ),
              ),
            ),
            // child: FittedBox(
            //   fit: BoxFit.fill,
            //   child: Image.network(
            //     userDataList[index]["image"].toString(),
            //   ),
            // ),
          ),

        ),
      ],
    );
  }
}
