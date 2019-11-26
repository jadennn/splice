import 'package:flutter/material.dart';

///自定义key
///Global Key for Player not refresh and measure child location
@optionalTypeArgs
class CustomGlobalKey<T extends State<StatefulWidget>> extends GlobalKey<T> {
  /// Creates a global key that uses [identical] on [value] for its [operator==].
  const CustomGlobalKey(this.value) : super.constructor();

  /// The object whose identity is used by this key's [operator==].
  final Object value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final CustomGlobalKey<T> typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => identityHashCode(value);
}
