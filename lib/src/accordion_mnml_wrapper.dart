import 'package:flutter/material.dart';
import 'accordion_mnml_item.dart';

/// A wrapper widget that manages a list of [AccordionMnmlItem]s.
///
/// It supports expanding multiple items simultaneously or restricting
/// to a single open item at a time using [isOneAtATime].
class AccordionMnmlWrapper extends StatefulWidget {
  /// Whether only one accordion item can be open at a time.
  ///
  /// If `true`, tapping an item will close all others.
  /// Defaults to `false`, allowing multiple items to be expanded.
  final bool isOneAtATime;

  /// The list of accordion items to render inside the wrapper.
  final List<AccordionMnmlItem> items;

  /// Creates an [AccordionMnmlWrapper].
  ///
  /// The [items] parameter must not be null.
  const AccordionMnmlWrapper({
    super.key,
    this.isOneAtATime = false,
    required this.items,
  });

  @override
  State<AccordionMnmlWrapper> createState() => _AccordionMnmlWrapperState();
}

class _AccordionMnmlWrapperState extends State<AccordionMnmlWrapper> {
  late List<bool> expandedStates;

  @override
  void initState() {
    super.initState();
    expandedStates = widget.items.map((e) => e.initallyExpanded).toList();
  }

  /// Handles item header taps to toggle expansion states.
  ///
  /// When [widget.isOneAtATime] is `true`, this ensures that only one
  /// item remains open at a time.
  void _handleItemTapped(int index) {
    setState(() {
      if (widget.isOneAtATime) {
        for (int i = 0; i < expandedStates.length; i++) {
          expandedStates[i] = i == index ? !expandedStates[i] : false;
        }
      } else {
        expandedStates[index] = !expandedStates[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return AccordionMnmlItem(
          title: item.title,
          animationDuration: item.animationDuration,
          headerPrefixIcon: item.headerPrefixIcon,
          headerBackgroundColor: item.headerBackgroundColor,
          padding: item.padding,
          margin: item.margin,
          backgroundColor: item.backgroundColor,
          borderColor: item.borderColor,
          borderRadius: item.borderRadius,
          borderWidth: item.borderWidth,
          dividerColor: item.dividerColor,
          dividerThickness: item.dividerThickness,
          titleTextStyle: item.titleTextStyle,
          boxShadows: item.boxShadows,
          initallyExpanded: expandedStates[index],
          onHeaderTap: () => _handleItemTapped(index),
          child: item.child,
        );
      },
    );
  }
}
