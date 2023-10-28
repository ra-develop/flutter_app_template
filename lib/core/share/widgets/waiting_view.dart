import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WaitingViewArgs {
  final Duration? duration;
  final String? message;
  final Widget? infoIcon;
  final bool linearMode;
  final Color? color;
  final Widget? actions;

  WaitingViewArgs({
    this.message,
    this.duration,
    this.infoIcon,
    this.linearMode = false,
    this.color,
    this.actions,
  });
}

class WaitingView extends HookWidget {
  const WaitingView({
    Key? key,
    this.message,
    this.duration,
    this.infoIcon,
    this.linearMode = false,
    this.color,
    this.actions,
  }) : super(key: key);

  final Duration? duration;
  final String? message;
  final Widget? infoIcon;
  final bool linearMode;
  final Color? color;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: color /*HexColor("#F31753")*/);
    final total = duration?.inSeconds ?? 1;
    final step = 1 / (total == 0 ? 1 : total);
    final counter = useState(0.0);
    final controller = useAnimationController(
        duration: duration ?? const Duration(seconds: 1));
    controller.stop();
    controller.addListener(() {
      counter.value = controller.value;
    });
    controller.forward();
    final isLogPrinted = useState(false);
    if (message != null && !isLogPrinted.value) {
      developer.log(message!, name: "WaitingView");
      isLogPrinted.value = true;
    }
    // controller.repeat(reverse: true);
    return Scaffold(
      body: Visibility(
        visible: !linearMode,
        replacement: Container(
          height: 60,
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 5,
            child: LinearProgressIndicator(
              value: (duration != null && duration != Duration.zero)
                  ? counter.value
                  : null,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: duration == null
                  ? infoIcon != null
                      ? SizedBox(
                          width: 50,
                          height: 50,
                          child: infoIcon,
                        )
                      : Text(
                          "",
                          style: textStyle,
                        )
                  : Text(
                      ((total - counter.value / step) + 1).toInt().toString(),
                      style: textStyle),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: color,
                  value: (duration != null && duration != Duration.zero)
                      ? counter.value
                      : null,
                  // semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.9),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 60),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 - 130,
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Text(
                          message != null ? message.toString() : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: color),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: counter.value >= 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      height: 60,
                      child: actions ??
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          )),
                ),
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}

class WarningSign extends StatelessWidget {
  final Color? color;

  const WarningSign({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "!",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 40,
          fontFamily: 'open_sans',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
