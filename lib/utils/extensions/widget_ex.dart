import 'package:flutter/material.dart';

extension WidgetEx on Widget {
  Padding addPadding({required EdgeInsetsGeometry padding}) {
    return Padding(padding: padding, child: this);
  }

  Widget addCenter() {
    return Center(child: this);
  }

  Widget addExpanded({int? flex}) {
    return Expanded(flex: flex ?? 1, child: this);
  }

  Widget addAlign({required AlignmentGeometry alignment}) {
    return Align(alignment: alignment, child: this);
  }

  Widget addSizedBox({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget addContainer({
    double? width,
    double? height,
    Color? color,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      color: color,
      margin: margin,
      padding: padding,
      child: this,
    );
  }

  Widget addHero({required Object tag}) {
    return Hero(tag: tag, child: this);
  }

  Widget addOpacity({required double opacity}) {
    return Opacity(opacity: opacity, child: this);
  }

  Widget addInkWell({required VoidCallback onTap, BorderRadius? borderRadius}) {
    return InkWell(onTap: onTap, child: this, borderRadius: borderRadius);
  }

  Widget addForm({required GlobalKey<FormState> key}) {
    return Form(key: key, child: this);
  }

  Widget addScrollView({
    ScrollController? controller,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
  }) {
    return SingleChildScrollView(
      controller: controller,
      physics: physics,
      padding: padding,
      child: this,
    );
  }
}

extension WidgetListEx on List<Widget> {
  Widget addStack({AlignmentGeometry? alignment, StackFit? fit}) {
    return Stack(
      fit: fit ?? StackFit.loose,
      alignment: alignment ?? AlignmentDirectional.topStart,
      children: this,
    );
  }

  Widget addColumn({
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: this,
    );
  }

  Widget addRow({
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: this,
    );
  }

  Widget addListView({
    Key? key,
    Axis? scrollDirection,
    ScrollPhysics? physics,
    bool? shrinkWrap,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
  }) {
    return ListView(
      key: key,
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: physics,
      controller: controller,
      shrinkWrap: shrinkWrap ?? false,
      padding: padding,
      children: this,
    );
  }
}
