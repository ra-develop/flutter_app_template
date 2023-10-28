import 'package:flutter/cupertino.dart';

class VSpacer extends StatelessWidget {
  ///  Vertical sized box, default: 20

  const VSpacer(this.size, {super.key});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 20,
    );
  }
}

class HSpacer extends StatelessWidget {
  /// Horizontal sized box, default size: 10

  const HSpacer(this.size, {super.key});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 10,
    );
  }
}
