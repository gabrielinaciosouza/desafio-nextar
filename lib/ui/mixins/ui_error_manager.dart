import 'package:desafio_nextar/ui/pages/login/components/components.dart';
import 'package:flutter/material.dart';

import '../helpers/errors/errors.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?>? stream) {
    stream!.listen((error) {
      print(error.toString());
      if (error != UIError.none) showErrorMessage(context, error!.description!);
    });
  }
}
