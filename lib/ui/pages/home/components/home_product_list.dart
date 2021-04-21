import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../home.dart';

class HomeProductList extends StatelessWidget {
  final List<ProductViewModel>? productViewModel;

  HomeProductList({required this.productViewModel});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productViewModel!.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 0.6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 40),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 0.7)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.asset(
                    'lib/ui/assets/iphone.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              LayoutBuilder(builder: (context, constraints) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: constraints.maxHeight * .5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1, // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ResponsiveHeadline6(
                          text: productViewModel![index].name,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        ResponsiveHeadline6(
                          text: productViewModel![index].price == null
                              ? 'Produto sem preço!'
                              : 'R\$ ${productViewModel![index].price!.toStringAsFixed(2)}',
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
