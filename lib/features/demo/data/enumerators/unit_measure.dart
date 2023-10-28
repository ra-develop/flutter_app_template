enum UnitMeasure { metric, imperial, standard }

extension UnitMeasureExtension on UnitMeasure {
  String get capitalName {
    switch (this) {
      case UnitMeasure.metric:
        return "Celsius";
      case UnitMeasure.imperial:
        return "Fahrenheit";
      case UnitMeasure.standard:
        return "Kelvin";
    }
  }

  String get unitSign {
    switch (this) {
      case UnitMeasure.metric:
        return "˚C";
      case UnitMeasure.imperial:
        return "˚F";
      case UnitMeasure.standard:
        return "˚K";
    }
  }

//meter/sec, Metric: meter/sec, Imperial: miles/hour
  String get speed {
    switch (this) {
      case UnitMeasure.metric:
        return "meter/sec";
      case UnitMeasure.imperial:
        return "miles/hour";
      case UnitMeasure.standard:
        return "meter/sec";
    }
  }
}
