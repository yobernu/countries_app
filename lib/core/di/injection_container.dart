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

  // box for favourites
  final favoritesBox = await Hive.openBox<CountrySummaryModel>('favorites');
  sl.registerLazySingleton<Box<CountrySummaryModel>>(
    () => favoritesBox,
    instanceName: 'favorites',
  );

  // box used to cache the list shown on home/search screens
  final cacheBox = await Hive.openBox<CountrySummaryModel>('cached_countries');
  sl.registerLazySingleton<Box<CountrySummaryModel>>(
    () => cacheBox,
    instanceName: 'cache',
  );

  sl.registerLazySingleton<ICountryLocalDataSource>(
    () => CountryLocalDataSource(
      sl<Box<CountrySummaryModel>>(instanceName: 'favorites'),
      sl<Box<CountrySummaryModel>>(instanceName: 'cache'),
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

