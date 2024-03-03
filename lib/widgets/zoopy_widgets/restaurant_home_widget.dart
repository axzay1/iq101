import 'package:flutter/material.dart';

class RestaurantHomeScreenWidget extends StatefulWidget {
  const RestaurantHomeScreenWidget({super.key});

  @override
  State<RestaurantHomeScreenWidget> createState() => _RestaurantHomeScreenWidgetState();
}

class _RestaurantHomeScreenWidgetState extends State<RestaurantHomeScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.4,
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 6.0, // spacing between rows
            crossAxisSpacing: 6.0, // spacing between columns
          ),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index){
                return  SizedBox(

                    height: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                );
              })
      ),
    );
  }
}