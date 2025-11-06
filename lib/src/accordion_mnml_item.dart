import 'package:flutter/material.dart';

/// A minimalist accordion item widget that expands or collapses
/// to show or hide its [child] when tapped.
///
/// Used together with [AccordionMnmlWrapper] to create
/// collapsible sections in a list or settings screen.
class AccordionMnmlItem extends StatefulWidget {
  /// Optional icon displayed before the header title.
  final Icon? headerPrefixIcon;

  /// Background color of the header section.
  final Color? headerBackgroundColor;

  /// The widget content shown when the accordion is expanded.
  final Widget child;

  /// Duration of the expand/collapse animation.
  ///
  /// Defaults to 400 milliseconds.
  final Duration animationDuration;

  /// Internal padding inside the accordion item container.
  final EdgeInsetsGeometry? padding;

  /// External margin outside the accordion item container.
  final EdgeInsetsGeometry? margin;

  /// Background color of the entire accordion item.
  final Color? backgroundColor;

  /// Border color around the accordion container.
  final Color? borderColor;

  /// Corner radius of the accordion container.
  final double? borderRadius;

  /// Border width of the accordion container.
  final double? borderWidth;

  /// Color of the optional divider inside the accordion.
  final Color? dividerColor;

  /// Whether the accordion should be initially expanded.
  ///
  /// Defaults to `false`.
  final bool initallyExpanded;

  /// Divider line thickness if [dividerColor] is used.
  final double? dividerThickness;

  /// Optional list of [BoxShadow] applied to the container.
  final List<BoxShadow>? boxShadows;

  /// The text title displayed in the header.
  final String title;

  /// The text style applied to [title].
  final TextStyle? titleTextStyle;

  /// Callback triggered when the header is tapped.
  ///
  /// Used by [AccordionMnmlWrapper] to synchronize expansion states.
  final VoidCallback? onHeaderTap;

  /// Creates a new [AccordionMnmlItem].
  ///
  /// The [child] widget is required.
  const AccordionMnmlItem({
    super.key,
    this.title = "Accordion Item",
    required this.child,
    this.animationDuration = const Duration(milliseconds: 400),
    this.boxShadows,
    this.headerPrefixIcon,
    this.headerBackgroundColor,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.dividerColor,
    this.dividerThickness,
    this.titleTextStyle,
    this.onHeaderTap,
    this.initallyExpanded = false,
  });

  @override
  State<AccordionMnmlItem> createState() => _AccordionMnmlItemState();
}

class _AccordionMnmlItemState extends State<AccordionMnmlItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initallyExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (_expanded) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AccordionMnmlItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initallyExpanded != oldWidget.initallyExpanded) {
      _expanded = widget.initallyExpanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Toggles the expanded/collapsed state of this item.
  ///
  /// Invokes [widget.onHeaderTap] if provided.
  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onHeaderTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        border: Border.all(
          color: widget.borderColor ?? Colors.black12,
          width: widget.borderWidth ?? 1,
        ),
        boxShadow: widget.boxShadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggle,
            child: Row(
              children: [
                if (widget.headerPrefixIcon != null) ...[
                  widget.headerPrefixIcon!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    widget.title,
                    style: widget.titleTextStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
