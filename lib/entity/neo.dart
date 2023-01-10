class Neo {
  Neo(this._name,
      this._absoluteMagnitudeH,
      this._isPotentiallyHazardousAsteroid,
      this._isSentryObject);

  final String _name;
  final double _absoluteMagnitudeH;
  final bool _isPotentiallyHazardousAsteroid;
  final bool _isSentryObject;

  String get returnName => this._name;

  double get returnAbsoluteMagnitudeH => this._absoluteMagnitudeH;

  bool get returnIsPotentiallyHazardousAsteroid => this._isPotentiallyHazardousAsteroid;

  bool get returnIsSentryObject => this._isSentryObject;
}