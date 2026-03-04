import 'dart:async';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/theme/theme_bloc.dart';
import '../bloc/country_list/country_list_bloc.dart';
import '../bloc/country_list/country_list_event.dart';
import '../bloc/country_list/country_list_state.dart';
import '../widgets/countries_list.dart';
import 'details_screen.dart';
import '../widgets/countries_list_shimmer.dart';
import '../widgets/search_box.dart';
import '../widgets/ui_states.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  int _selectedIndex = 0;

  // filtering/sorting state
  String _sortField = 'default'; // 'default', 'name' or 'population'
  bool _sortAsc = true;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    final bloc = context.read<CountryListBloc>();
    final completer = Completer<void>();
    late final StreamSubscription<CountryListState> sub;
    sub = bloc.stream.listen((state) {
      if (state.status != CountryListStatus.loading) {
        completer.complete();
        sub.cancel();
      }
    });
    bloc.add(const LoadAllCountries());
    return completer.future;
  }

  Widget _scrollableWrapper(Widget child) {
    if (child is ScrollView) return child;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      context.read<CountryListBloc>().add(SearchCountriesEvent(value));
    });
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeTooltip(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
      case ThemeMode.system:
        return 'System theme';
    }
  }

  String _getSortLabel() {
    switch (_sortField) {
      case 'name':
        return 'Name';
      case 'population':
        return 'Population';
      default:
        return 'Default';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildHomeTab() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'Countries',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SearchBox(
                      controller: _controller,
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) {
                      return IconButton(
                        onPressed: () {
                          context.read<ThemeBloc>().add(ToggleThemeEvent());
                        },
                        icon: Icon(_getThemeIcon(themeState.themeMode)),
                        tooltip: _getThemeTooltip(themeState.themeMode),
                      );
                    },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        if (value == 'default') {
                          _sortField = 'default';
                          _sortAsc = true;
                          return;
                        }

                        if (value == 'name' || value == 'population') {
                          if (_sortField == value) {
                            _sortAsc = !_sortAsc;
                          } else {
                            _sortField = value;
                            _sortAsc = true;
                          }
                        }
                      });
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'default',
                        child: Row(
                          children: [
                            Icon(
                              _sortField == 'default'
                                  ? Icons.check
                                  : Icons.unfold_more,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text('Default'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'name',
                        child: Row(
                          children: [
                            Icon(
                              _sortField == 'name'
                                  ? (_sortAsc
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward)
                                  : Icons.sort_by_alpha,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text('Name'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'population',
                        child: Row(
                          children: [
                            Icon(
                              _sortField == 'population'
                                  ? (_sortAsc
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward)
                                  : Icons.people_alt_outlined,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text('Population'),
                          ],
                        ),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.getSurface(context),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withAlpha(180),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.filter_list, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            _getSortLabel(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (_sortField != 'default') ...[
                            const SizedBox(width: 4),
                            Icon(
                              _sortAsc
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 18,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.primary,
                  backgroundColor: AppColors.getSurface(context),
                  edgeOffset: 16,
                  strokeWidth: 3.0,
                  displacement: 40,
                  child: BlocBuilder<CountryListBloc, CountryListState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case CountryListStatus.loading:
                          return _scrollableWrapper(
                              const CountriesListShimmer());
                        case CountryListStatus.error:
                          return _scrollableWrapper(
                            ErrorStateView(
                              message: state.message,
                              onRetry: () => context
                                  .read<CountryListBloc>()
                                  .add(const LoadAllCountries()),
                            ),
                          );
                        case CountryListStatus.empty:
                          return _scrollableWrapper(
                            const EmptyStateView(
                              message: 'No countries found.',
                            ),
                          );
                        case CountryListStatus.success:
                          // make a mutable copy for sorting
                          final list = List.of(state.countries);
                          if (_sortField == 'name') {
                            list.sort((a, b) => _sortAsc
                                ? a.name.compareTo(b.name)
                                : b.name.compareTo(a.name));
                          } else if (_sortField == 'population') {
                            list.sort((a, b) => _sortAsc
                                ? a.population.compareTo(b.population)
                                : b.population.compareTo(a.population));
                          }
                          return CountriesList(
                            countries: list,
                            useSearchCard: _controller.text.isNotEmpty,
                            onCountryTap: (country) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsScreen(
                                    cca2: country.cca2,
                                    countryName: country.name,
                                  ),
                                ),
                              );
                            },
                          );
                        case CountryListStatus.initial:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          buildHomeTab(),
          const FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (idx) {
          setState(() => _selectedIndex = idx);
        },
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
