import 'package:flutter/material.dart';

// Widget ch = AnimatedContainer(
//   duration: Duration(milliseconds: 500),
//   clipBehavior: Clip.antiAliasWithSaveLayer,
//   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//   width: MediaQuery.sizeOf(context).width,
//   decoration: ShapeDecoration(
//     color: Theme.of(context).cardTheme.color,
//     shadows: [
//       BoxShadow(
//         color: Colors.amber.withAlpha(20),
//         blurRadius: 5,
//         blurStyle: BlurStyle.outer,
//       ),
//     ],
//     shape: RoundedSuperellipseBorder(
//       borderRadius: BorderRadius.circular(8),
//       side: BorderSide(color: Colors.black12.withAlpha(20)),
//     ),
//   ),
// );

class MyExpandingWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final bool initallyExpanded;
  final double fontSize;
  final Color clr;
  const MyExpandingWidget({
    super.key,
    required this.child,
    required this.title,
    this.initallyExpanded = false,
    this.fontSize = 18,
    this.clr = Colors.black,
  });

  @override
  _MyExpandingWidgetState createState() => _MyExpandingWidgetState();
}

class _MyExpandingWidgetState extends State<MyExpandingWidget> {
  late ExpansibleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpansibleController();
    if (widget.initallyExpanded) {
      _controller.expand();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expansible(
      controller: _controller,
      headerBuilder: (context, animation) {
        return InkWell(
          onTap: () {
            if (_controller.isExpanded) {
              _controller.collapse();
            } else {
              _controller.expand();
            }
          },
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w600,
                    color: widget.clr,
                  ),
                ),
                Spacer(),
                // Maybe an arrow icon that rotates with animation
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(animation),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        );
      },
      bodyBuilder: (context, animation) {
        // Hidden / shown part
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: widget.child,
        );
      },
      // Optionally adjust animation duration, etc.
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
