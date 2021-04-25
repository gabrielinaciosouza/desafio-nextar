import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:desafio_nextar/ui/pages/home/home.dart';
import 'package:flutter/material.dart';

class HomeAvatar extends StatelessWidget {
  final HomePresenter presenter;
  HomeAvatar({required this.presenter});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presenter.logoff,
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: presenter.goToNewProduct,
                  child: Text(R.strings.newProduct),
                ),
                CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'lib/ui/assets/avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
