class WeatherModel {
  var temp;
  var maxtemp;
  var mintemp;
  var pressure;
  var humidity;
  String weatherinfo;
  String weatherdesc;
  var windspeed;
  var winddirection;
  String city;
  var visibility;
  WeatherModel(
      {this.temp,
      this.maxtemp,
      this.mintemp,
      this.pressure,
      this.humidity,
      this.weatherinfo,
      this.weatherdesc,
      this.windspeed,
      this.winddirection,
      this.city,
      this.visibility});
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        temp: json['main']['temp'],
        maxtemp: json['main']['temp_max'],
        mintemp: json['main']['temp_min'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        weatherinfo: json['weather'][0]['main'],
        weatherdesc: json['weather'][0]['description'],
        windspeed: json['wind']['speed'],
        winddirection: json['wind']['deg'],
        city: json['name'],
        visibility: json['visibility']);
  }
}
