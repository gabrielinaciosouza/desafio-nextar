import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../home.dart';

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<HomePresenter>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveHeadline1(text: R.strings.explore, color: Colors.white),
        IconButton(
          onPressed: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.all(25),
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResponsiveHeadline6(
                                  text: R.strings.date, color: Colors.white),
                              ResponsiveHeadline6(
                                  text: R.strings.alphabetic,
                                  color: Colors.white),
                              ResponsiveHeadline6(
                                  text: R.strings.price, color: Colors.white),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_upward),
                                    label: Text(R.strings.increasing),
                                    onPressed: () =>
                                        presenter.dateFilter(increasing: true),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_downward),
                                    label: Text(R.strings.decreasing),
                                    onPressed: () =>
                                        presenter.dateFilter(increasing: false),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_upward),
                                    label: Text(R.strings.increasing),
                                    onPressed: () => presenter.alphabeticFilter(
                                        increasing: true),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_downward),
                                    label: Text(R.strings.decreasing),
                                    onPressed: () => presenter.alphabeticFilter(
                                        increasing: false),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_upward),
                                    label: Text(R.strings.increasing),
                                    onPressed: () =>
                                        presenter.priceFilter(increasing: true),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.arrow_downward),
                                    label: Text(R.strings.decreasing),
                                    onPressed: () => presenter.priceFilter(
                                        increasing: false),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          icon: Icon(
            Icons.filter_alt,
            size: 40,
          ),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
