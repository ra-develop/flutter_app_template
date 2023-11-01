import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WaitingViewArgs {
  final Duration? duration;
  final String? message;
  final Widget? infoIcon;
  final bool linearMode;
  final Color? color;
  final List<Widget>? actions;

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
  final List<Widget>? actions;

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
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        _buildActionsButtons(counter, context),
      ],
      body: Visibility(
        visible: !linearMode,
        replacement: _buildLinearProgressIndicator(counter),
        child: _buildCircularProgressIndicator(
            textStyle, total, counter, step, context),
      ),
    );
  }

  Container _buildLinearProgressIndicator(ValueNotifier<double> counter) {
    return Container(
      height: 60,
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 5,
        child: LinearProgressIndicator(
          color: color,
          value: (duration != null && duration != Duration.zero)
              ? counter.value
              : null,
        ),
      ),
    );
  }

  Widget _buildCircularProgressIndicator(TextStyle textStyle, int total,
      ValueNotifier<double> counter, double step, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        // direction: Axis.vertical,
        children: [
          // const Gap.expand(10),
          _buildCircularProgressView(
            textStyle,
            total,
            counter,
            step,
          ),
          _buildTextMessage(context),
        ],
      ),
    );
  }

  Widget _buildCircularProgressView(
    TextStyle textStyle,
    int total,
    ValueNotifier<double> counter,
    double step,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                : Text(((total - counter.value / step) + 1).toInt().toString(),
                    style: textStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildTextMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 0),
      child: LimitedBox(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height - 220,
        child: SingleChildScrollView(
            child: Text(
          message != null ? message.toString() : '',
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        )),
      ),
    );
  }

  Visibility _buildActionsButtons(
      ValueNotifier<double> counter, BuildContext context) {
    return Visibility(
      visible: counter.value >= 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions ??
            [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ),
            ],
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
