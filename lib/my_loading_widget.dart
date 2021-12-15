import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';


class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 35,
        height: 35,
        child: LoadingIndicator(
          color: Theme.of(context).primaryColor,
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
