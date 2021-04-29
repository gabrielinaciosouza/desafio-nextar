import 'package:flutter/material.dart';

import '../../../pages/pages.dart';
import '../../../helpers/helpers.dart';

import '../../../components/components.dart';

dynamic showDeleteModal(
        {required BuildContext context,
        required HomePresenter presenter,
        required AsyncSnapshot snapshot,
        required int index}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ResponsiveHeadline6(
              color: Theme.of(context).primaryColor,
              text: R.strings.atention,
            ),
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.of(context).pop())
          ],
        ),
        content: ResponsiveHeadline6(
          color: Theme.of(context).primaryColorLight,
          text: R.strings.questionDelete,
        ),
        actions: [
          ElevatedButton(
            onPressed: () =>
                presenter.deleteProduct(snapshot.data![index].code),
            child: ResponsiveHeadline6(
              color: Theme.of(context).primaryColorLight,
              text: R.strings.yes,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
