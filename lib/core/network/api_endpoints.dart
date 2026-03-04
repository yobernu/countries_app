class ApiEndpoints {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  // Step 1: Minimal Data for Lists
  // https://restcountries.com/v3.1/all?fields=name,flags,population,cca2
  static const String allCountries = '/all';

  // https://restcountries.com/v3.1/name/{name}?fields=name,flags,population,cca2
  static String searchCountries(String name) => '/name/$name';

  static const String summaryFields = 'name,flags,population,cca2,capital';

  // Step 2: Full Data for Detail Screen
  // https://restcountries.com/v3.1/alpha/{code}?fields=name,flags,population,capital,region,subregion,area,timezones
  static String getCountryDetails(String code) => '/alpha/$code';

  static const String detailFields =
      'name,flags,population,capital,region,subregion,area,timezones';
}
