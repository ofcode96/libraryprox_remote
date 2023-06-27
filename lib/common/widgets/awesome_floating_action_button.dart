// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:libraryprox_remote/constents/globales.dart';

class AwesomeFloatingActionBar extends StatefulWidget {
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;
  final void Function()? onTapAddToBorrow;
  final bool borrowState;

  const AwesomeFloatingActionBar({
    Key? key,
    this.onTapEdit,
    this.onTapDelete,
    this.onTapAddToBorrow,
    required this.borrowState,
  }) : super(key: key);

  @override
  State<AwesomeFloatingActionBar> createState() =>
      _AwesomeFloatingActionBarState();
}

class _AwesomeFloatingActionBarState extends State<AwesomeFloatingActionBar>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final curvedAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return FloatingActionBubble(
      items: [
        Bubble(
          icon: Icons.add,
          iconColor: Colors.white,
          title: local.toborrow,
          titleStyle: const TextStyle(fontSize: 15, color: Colors.white),
          bubbleColor: Colors.greenAccent,
          onPress: () {
            widget.onTapAddToBorrow!();
            _animationController!.reverse();
          },
        ),
        Bubble(
          icon: Icons.delete,
          iconColor: Colors.white,
          title: local.delete,
          titleStyle: const TextStyle(fontSize: 15, color: Colors.white),
          bubbleColor: Colors.redAccent,
          onPress: () {
            widget.onTapDelete!();
            _animationController!.reverse();
          },
        ),
        Bubble(
          icon: Icons.app_registration,
          iconColor: Colors.white,
          title: local.edit,
          titleStyle: const TextStyle(fontSize: 15, color: Colors.white),
          bubbleColor: Colors.orange,
          onPress: () {
            widget.onTapEdit!();
            _animationController!.reverse();
          },
        )
      ],
      iconColor: Colors.white,
      backGroundColor: Globals.primaryColor,
      animation: _animation!,
      iconData: Icons.settings,
      onPress: () {
        _animationController!.isCompleted
            ? _animationController!.reverse()
            : _animationController!.forward();
      },
    );
  }
}
