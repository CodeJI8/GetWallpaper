import 'package:flutter/material.dart';
import '../view/category_screen.dart';

class CatBlock extends StatelessWidget {
  final String imgSrc;
  final String categoryName;

  const CatBlock({
    super.key,
    required this.imgSrc,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              catImgUrl: imgSrc,
              catName: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imgSrc,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
