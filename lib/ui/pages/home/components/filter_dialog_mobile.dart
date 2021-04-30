import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

import '../home.dart';

dynamic filterDialogMobile(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ResponsiveHeadline6(
                              text: R.strings.date, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.dateFilter(increasing: true),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.dateFilter(increasing: false),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ResponsiveHeadline6(
                              text: R.strings.price, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.priceFilter(increasing: true),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.priceFilter(increasing: false),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ResponsiveHeadline6(
                              text: R.strings.alphabetic, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.alphabeticFilter(increasing: true),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              presenter.alphabeticFilter(increasing: false),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
