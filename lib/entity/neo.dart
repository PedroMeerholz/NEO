class Neo {
  Neo(
    this._name,
    this._absoluteMagnitudeH,
    this._minEstimatedDiameter,
    this._maxEstimatedDiameter,
    this._closeApproachDate,
    this._kilometersPerSecond,
    this._missDistance,
    this._isPotentiallyHazardousAsteroid,
    this._isSentryObject,
  );

  final String _name;
  final double _absoluteMagnitudeH;
  final double _minEstimatedDiameter;
  final double _maxEstimatedDiameter;
  final String _closeApproachDate;
  final String _kilometersPerSecond;
  final String _missDistance;
  final bool _isPotentiallyHazardousAsteroid;
  final bool _isSentryObject;

  String get returnName => this._name;

  double get returnAbsoluteMagnitudeH => this._absoluteMagnitudeH;

  bool get returnIsPotentiallyHazardousAsteroid =>
      this._isPotentiallyHazardousAsteroid;

  bool get returnIsSentryObject => this._isSentryObject;
}
