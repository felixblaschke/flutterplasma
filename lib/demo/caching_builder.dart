import 'package:flutter/widgets.dart';

/// Builds a widget by calling [builder]. Rebuilds the widget when [cacheKey]
/// changes.
///
/// Use this to prevent unnecessary rebuilds of expensive widgets by changing
/// the [cacheKey] only when a rebuild is necessary. Typically, the cache key
/// would consist of values used by [builder] to build the widget.
class CachingBuilder<V> extends StatefulWidget {
  const CachingBuilder({
    required this.cacheKey,
    required this.builder,
  });

  final V cacheKey;
  final WidgetBuilder builder;

  @override
  _CachingBuilderState<V> createState() => _CachingBuilderState<V>();
}

class _CachingBuilderState<V> extends State<CachingBuilder<V>> {
  V? _lastCacheKey;
  Widget? _cachedWidget;

  @override
  Widget build(BuildContext context) {
    if (_cachedWidget != null && _lastCacheKey == widget.cacheKey) {
      return _cachedWidget!;
    } else {
      _cachedWidget = widget.builder(context);
      _lastCacheKey = widget.cacheKey;
      return _cachedWidget!;
    }
  }
}
