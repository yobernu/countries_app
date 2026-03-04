import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../network/dio_client.dart';
import '../../ft_countries_car/data/datasources/country_local_data_source.dart';
import '../../ft_countries_car/data/datasources/country_remote_data_source.dart';
import '../../ft_countries_car/data/models/country_summary_model.dart';
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

  // Hive setup for local persistence
  await Hive.initFlutter();
  Hive.registerAdapter(CountrySummaryModelAdapter());

  // box for favourite country codes (cca2)
  final favoritesBox = await Hive.openBox<String>('favorite_codes');
  sl.registerLazySingleton<Box<String>>(
    () => favoritesBox,
    instanceName: 'favorites',
  );

  // box used to cache the list shown on home/search screens
  final cacheBox = await Hive.openBox<CountrySummaryModel>('cached_countries');
  sl.registerLazySingleton<Box<CountrySummaryModel>>(
    () => cacheBox,
    instanceName: 'cache',
  );

  // box for cached capitals keyed by cca2 (offline favorites support)
  final capitalBox = await Hive.openBox<String>('cached_capitals');
  sl.registerLazySingleton<Box<String>>(
    () => capitalBox,
    instanceName: 'capital',
  );

  sl.registerLazySingleton<ICountryLocalDataSource>(
    () => CountryLocalDataSource(
      sl<Box<String>>(instanceName: 'favorites'),
      sl<Box<CountrySummaryModel>>(instanceName: 'cache'),
      sl<Box<String>>(instanceName: 'capital'),
    ),
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

