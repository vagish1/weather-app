class LatlngModel {
  final double lat;
  final double lng;

  const LatlngModel({required this.lat, required this.lng});

  @override
  String toString() {
    // TODO: implement toString
    return "$lat,$lng";
  }
}
