import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';

import 'core/di/injection_container.dart';
import 'ft_countries_car/domain/usecases/get_all_countries.dart';
import 'ft_countries_car/domain/usecases/manage_favorites.dart';
import 'ft_countries_car/domain/usecases/search_countries.dart';
import 'ft_countries_car/presentation/bloc/country_list/country_list_bloc.dart';
import 'ft_countries_car/presentation/bloc/country_list/country_list_event.dart';
import 'ft_countries_car/presentation/bloc/favorites/favorites_bloc.dart';
import 'ft_countries_car/presentation/bloc/favorites/favorites_event.dart';
import 'ft_countries_car/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const CountriesApp());
}

class CountriesApp extends StatefulWidget {
  const CountriesApp({super.key});

  @override
  CountriesAppState createState() => CountriesAppState();
}

class CountriesAppState extends State<CountriesApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CountryListBloc(
            getAllCountries: sl<GetAllCountries>(),
            searchCountries: sl<SearchCountries>(),
          )..add(const LoadAllCountries()),
        ),
        // CountryDetailsBloc is provided locally by DetailsScreen when needed.
        BlocProvider(
          create: (_) => FavoritesBloc(sl<ManageFavorites>())
            ..add(const LoadFavorites()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Countries',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _themeMode,
        home: const HomeScreen(),
      ),
    );
  }
}

