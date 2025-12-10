import 'package:flutter/material.dart';
import '../../viewmodels/home.dart';

class CategoryWidget extends StatefulWidget {
  final List<Category> categoryList;

  CategoryWidget({required this.categoryList, super.key});

  @override
  State<CategoryWidget> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture ?? '', width: 40, height: 40),
                Text(
                  category.name ?? '',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
