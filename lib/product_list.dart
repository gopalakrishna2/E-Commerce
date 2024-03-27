import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/product_card.dart';
import 'package:shop_app_flutter/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata','U.S Polo'];
  late String selectedFilter;

  int currentPage = 0;
  @override
  void initState(){
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context){
    return   Scaffold(
      body: SafeArea( 
       //ingnors or avoids the top and bottom notch
        child: Column(
          children:[
             Row(
              children:[
                Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Shoes\nCollection',
                style: Theme.of(context).textTheme.titleLarge
                ),
              ),
            const Expanded(
              child:TextField( decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(225, 225, 225,1),
                  ),
                  borderRadius: BorderRadius.horizontal(left:Radius.circular(30),)
                )
              ),
              ),
              )
            ],
            ),
             SizedBox(
              height: 120,
               child: ListView.builder(
                  scrollDirection:Axis.horizontal,
                  itemCount:filters.length,
                  itemBuilder:(context, index){
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        ),

                        child: GestureDetector(
                          onTap: (){
                            selectedFilter = filter;
                            setState(() {   
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedFilter == filter? Theme.of(context).colorScheme.primary : const Color.fromRGBO(245, 247, 249, 1),
                            side: const BorderSide(color: Color.fromRGBO(245, 247, 249, 1),
                            ),
                            label:Text(filter),
                            padding: const EdgeInsets.symmetric(horizontal: 20,
                             vertical: 15
                             ),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
                             ),
                          ),
                        ),
                    );
                }
               ),
             ),
             Expanded(
               child: LayoutBuilder(
                builder: (context, constraints){
                  if(constraints.maxWidth > 1080){
                    return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.75,
                  ),
                  itemBuilder: (context ,index){
                    final product = products[index];
                     return GestureDetector(
                      onTap: () {
                        //of context is used to inherit the widget
                        Navigator.of(context).push( 
                          MaterialPageRoute(
                            builder:(context){
                              return ProductDetails(product: product);
                            } )); //pop it will pop up and removes the top most screen, push will add the screens one on above
                      },
                       child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven 
                        ? const Color.fromRGBO(216, 240, 253, 1)
                        : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                     );
                    },
                );
                
                  } else {
                    return ListView.builder(
                   itemCount: products.length,
                   itemBuilder: (context, index) {
                     final product = products[index];
                     return GestureDetector(
                      onTap: () {
                        //of context is used to inherit the widget
                        Navigator.of(context).push( 
                          MaterialPageRoute(
                            builder:(context){
                              return ProductDetails(product: product);
                            } )); //pop it will pop up and removes the top most screen, push will add the screens one on above
                      },
                       child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven 
                        ? const Color.fromRGBO(216, 240, 253, 1)
                        : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                     );
                    },                  
                    );
                  }
                }
                ),
             ),  
          ],
        ),
      ),
    );
  }
}