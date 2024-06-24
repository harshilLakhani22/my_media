/// An immutable set of values, specifying whether to avoid system intrusions for specific sides
class SafeAreaValues {
  const SafeAreaValues({
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
  });

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
}
