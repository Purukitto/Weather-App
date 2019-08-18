class WeatherCity {
  String as;
  String city;
  String country;
  String countryCode;
  String isp;
  double lat;
  double lon;
  String org;
  String query;
  String region;
  String regionName;
  String status;
  String timezone;
  String zip;

  WeatherCity(
      {this.as,
      this.city,
      this.country,
      this.countryCode,
      this.isp,
      this.lat,
      this.lon,
      this.org,
      this.query,
      this.region,
      this.regionName,
      this.status,
      this.timezone,
      this.zip});

  factory WeatherCity.fromJson(Map<String, dynamic> parsedJson) {
    return new WeatherCity(
      as: parsedJson['as'],
      city: parsedJson['city'],
      country: parsedJson['country'],
      countryCode: parsedJson['countryCode'],
      isp: parsedJson['isp'],
      lat: parsedJson['lat'],
      lon: parsedJson['lon'],
      org: parsedJson['org'],
      query: parsedJson['query'],
      region: parsedJson['region'],
      regionName: parsedJson['regionName'],
      status: parsedJson['status'],
      timezone: parsedJson['timezone'],
      zip: parsedJson['zip'],
    );
  }
}
