import 'package:flutter/material.dart';
import 'package:iq101/service/product_service.dart';

import '../../Screen/cap.dart';
import '../../model/category_model.dart';

class CategoryHomeScreenWidget extends StatefulWidget {
  const CategoryHomeScreenWidget({super.key});

  @override
  State<CategoryHomeScreenWidget> createState() => _CategoryHomeScreenWidgetState();
}



class _CategoryHomeScreenWidgetState extends State<CategoryHomeScreenWidget> {
List<CategoryModel> category = [];
  @override
  void initState(){
    getCategories();
  }

  void getCategories() async {
     category = await ProductService().getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
            itemCount: category.length,
            itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  Cap()));
            },
            child:  SizedBox(
              width: 70,
              height: 70,
              child: Image(
                image: NetworkImage(category[index].image)
              )
              ,
              )

          );
        })
      ),
    );
  }
}