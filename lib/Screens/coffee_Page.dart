import 'package:flutter/material.dart';
import 'model.dart';
import 'package:like_button/like_button.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({Key? key, required this.coffee}) : super(key: key);

  final Coffee coffee;

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffee.name),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(widget.coffee.imgPath),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.coffee.description,
              style: const TextStyle(
                  fontSize: 18
              ),),
            const SizedBox(
              height: 20,
            ),
            LikeButton(
              size: 30,
              isLiked: isLiked,
              likeCount: likeCount,
            )
          ],
        ),
      ),
    );
  }
}



