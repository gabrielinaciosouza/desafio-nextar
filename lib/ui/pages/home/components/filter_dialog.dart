import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

import '../home.dart';

dynamic filterDialog(
        {required BuildContext context, required HomePresenter presenter}) =>
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
                          text: R.strings.alphabetic, color: Colors.white),
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
                            onPressed: () =>
                                presenter.alphabeticFilter(increasing: true),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.arrow_downward),
                            label: Text(R.strings.decreasing),
                            onPressed: () =>
                                presenter.alphabeticFilter(increasing: false),
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
                            onPressed: () =>
                                presenter.priceFilter(increasing: false),
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
