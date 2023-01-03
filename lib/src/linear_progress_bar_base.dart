import 'package:flutter/material.dart';

enum StepStatus { passed, active, future }

const primaryColor = Colors.red;
const disabledColor = Colors.grey;

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar(
      {super.key,
      required this.icons,
      required this.currentIndex,
      this.maxDisplayItems = 5});

  final List<Widget> icons;
  final int currentIndex;
  final int maxDisplayItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildItems,
    );
  }

  List<Widget> get _buildItems {
    // initial variables
    final result = <Widget>[];
    final totalItems = icons.length;
    final guard = (maxDisplayItems / 2).round();

    final deviationValue = 0.1;

    // compute guards

    final currentStep = currentIndex + 1;
    final level = currentIndex < maxDisplayItems
        ? 0
        : ((currentStep - maxDisplayItems) / guard - deviationValue).floor() +
            1;

    final startIndex = level + 3;
    var endIndex = startIndex + maxDisplayItems;

    if (endIndex >= totalItems) {
      endIndex = totalItems;
    }

    if (endIndex >= maxDisplayItems) {
      result.add(SizedBox(
        width: 15,
        child: Divider(
          color: primaryColor,
          height: 10,
        ),
      ));
    }

    for (var i = startIndex; i < endIndex; i++) {
      final status = _stepStatus(i);
      result.add(_buildItem(icons[i], status));

      final allowAddDash = i != endIndex - 1;
      if (allowAddDash) {
        result.add(_buildHorizontalLine(status));
      }
    }

    return result;
  }

  _stepStatus(int i) {
    if (i == currentIndex) {
      return StepStatus.active;
    } else if (i < currentIndex) {
      return StepStatus.passed;
    }
    return StepStatus.future;
  }

  Widget _buildItem(Widget icon, StepStatus status) {
    switch (status) {
      case StepStatus.passed:
        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: icon,
        );
      case StepStatus.active:
        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: primaryColor,
            ),
          ),
          child: icon,
        );
      case StepStatus.future:
        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: disabledColor,
            ),
          ),
          child: icon,
        );
    }
  }

  Widget _buildHorizontalLine(
    StepStatus status,
  ) {
    return Expanded(
        child: Divider(
      height: 2,
      color: status == StepStatus.active ? primaryColor : disabledColor,
    ));
  }
}
