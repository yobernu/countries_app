import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../../ft_countries_car/data/datasources/country_local_data_source.dart';
import '../../ft_countries_car/data/datasources/country_remote_data_source.dart';
import '../../ft_countries_car/data/repositories/country_repository_impl.dart';
import '../../ft_countries_car/domain/repositories/country_repository.dart';
import '../../ft_countries_car/domain/usecases/get_all_countries.dart';
import '../../ft_countries_car/domain/usecases/get_country_details.dart';
import '../../ft_countries_car/domain/usecases/manage_favorites.dart';
import '../../ft_countries_car/domain/usecases/search_countries.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data sources
  sl.registerLazySingleton<ICountryRemoteDataSource>(
    () => CountryRemoteDataSource(sl<DioClient>()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<ICountryLocalDataSource>(
    () => CountryLocalDataSource(sl<SharedPreferences>()),
  );

  // Repository
  sl.registerLazySingleton<ICountryRepository>(
    () => CountryRepositoryImpl(
      remoteDataSource: sl<ICountryRemoteDataSource>(),
      localDataSource: sl<ICountryLocalDataSource>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetAllCountries>(
    () => GetAllCountries(sl<ICountryRepository>()),
  );
  sl.registerLazySingleton<SearchCountries>(
    () => SearchCountries(sl<ICountryRepository>()),
  );
  sl.registerLazySingleton<GetCountryDetails>(
    () => GetCountryDetails(sl<ICountryRepository>()),
  );
  sl.registerLazySingleton<ManageFavorites>(
    () => ManageFavorites(sl<ICountryRepository>()),
  );
}

