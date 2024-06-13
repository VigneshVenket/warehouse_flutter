import 'package:flutter/material.dart';

import '../../tweaks/app_localization.dart';

class AddShippingScreen extends StatefulWidget {
  @override
  _AddShippingState createState() => _AddShippingState();
}

class _AddShippingState extends State<AddShippingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
            AppLocalizations.of(context)!.translate("Add Address")!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
        body: Center(child: Text(
          AppLocalizations.of(context)!.translate("Add Address")!,
        ),)
    );
  }
}
