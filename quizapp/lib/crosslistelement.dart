import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class CrossListElement extends StatelessWidget {
  const CrossListElement({
    super.key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
    this.divider = true,
  });

  final Widget child;
  final bool enabled;
  final bool divider;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isIOS
            ? CupertinoInkWell(
                onPressed: onPressed,
                child: OnTapScaleAndFade(
                  onTap: onPressed!,
                  lowerBound: 0.98,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              )
            : InkWell(
                onTap: onPressed,
                child: OnTapScaleAndFade(
                  lowerBound: 0.98,
                  onTap: onPressed!,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              ),
        divider
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).dividerColor,
                ),
                height: 0.6,
              )
            : const SizedBox(),
      ],
    );
  }
}

class CupertinoInkWell extends StatefulWidget {
  const CupertinoInkWell({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  bool get enabled => onPressed != null;

  @override
  State<CupertinoInkWell> createState() => _CupertinoInkWellState();
}

class _CupertinoInkWellState extends State<CupertinoInkWell> {
  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = true;
      });
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: AnimatedContainer(
          color: _buttonHeldDown
              ? Theme.of(context).dividerColor.withAlpha(100)
              : Theme.of(context).scaffoldBackgroundColor,
          duration: const Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OnTapScaleAndFade extends StatefulWidget {
  final Widget child;
  final void Function() onTap;
  double lowerBound = 0.85;
  OnTapScaleAndFade(
      {super.key,
      required this.child,
      required this.onTap,
      this.lowerBound = 0.85});

  @override
  // ignore: library_private_types_in_public_api
  _OnTapScaleAndFadeState createState() => _OnTapScaleAndFadeState();
}

class _OnTapScaleAndFadeState extends State<OnTapScaleAndFade>
    with TickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerA;
  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      lowerBound: widget.lowerBound,
      upperBound: 1.0,
      value: 1,
      duration: const Duration(milliseconds: 50),
    );
    _controllerA.addListener(() {
      setState(() {
        squareScaleA = _controllerA.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _controllerA.reverse();
        widget.onTap();
      },
      onTapDown: (dp) {
        _controllerA.reverse();
      },
      onTapUp: (dp) {
        Timer(const Duration(milliseconds: 50), () {
          _controllerA.fling();
        });
      },
      onTapCancel: () {
        _controllerA.fling();
      },
      child: Transform.scale(
        scale: squareScaleA,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }
}
