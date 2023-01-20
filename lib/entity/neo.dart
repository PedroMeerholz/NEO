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

  String get returnName => _name;

  double get returnAbsoluteMagnitudeH => _absoluteMagnitudeH;

  bool get returnIsPotentiallyHazardousAsteroid =>
      _isPotentiallyHazardousAsteroid;

  bool get returnIsSentryObject => _isSentryObject;

  double get returnMinEstimatedDiameter => _minEstimatedDiameter;

  double get returnMaxEstimatedDiameter => _maxEstimatedDiameter;

  String get returnCloseApproachDate => _closeApproachDate;

  String get returnKilometersPerSecond => _kilometersPerSecond;

  String get returnMissDistance => _missDistance;
}
