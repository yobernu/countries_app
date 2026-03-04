import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:countries_app/core/di/injection_container.dart';
import 'package:countries_app/ft_countries_car/domain/usecases/get_country_details.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_details/country_details_bloc.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_details/country_details_event.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_details/country_details_state.dart';
import 'package:countries_app/ft_countries_car/presentation/widgets/key_stats.dart';
import 'package:countries_app/ft_countries_car/presentation/widgets/time_zone.dart';
import 'package:countries_app/core/utils/formatters.dart';

class DetailsScreen extends StatelessWidget {
  final String cca2;
  final String countryName;

  const DetailsScreen({super.key, required this.cca2, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryDetailsBloc(sl<GetCountryDetails>())
        ..add(LoadCountryDetails(cca2)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(countryName, style: Theme.of(context).textTheme.titleMedium),
        ),
        body: BlocBuilder<CountryDetailsBloc, CountryDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case CountryDetailsStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case CountryDetailsStatus.error:
                return Center(child: Text(state.message));
              case CountryDetailsStatus.success:
                final country = state.country!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: cca2,
                          child: CachedNetworkImage(
                            imageUrl: country.flag,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.fill,
                            placeholder: (_, __) => Container(
                              height: 300,
                              color: Colors.grey.shade200,
                            ),
                            errorWidget: (_, __, ___) => Container(
                              height: 300,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.flag_outlined),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Key Statistics',
                                  style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.w800) ??
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8),
                              KeyStats(
                                  label: 'Area',
                                  value: formatArea(country.area)),
                              KeyStats(
                                  label: 'Population',
                                  value: formatPopulation(country.population)),
                              KeyStats(
                                  label: 'Capital', value: country.capital),
                              KeyStats(label: 'Region', value: country.region),
                              KeyStats(
                                  label: 'Subregion', value: country.subregion),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          // THIS FIXES THE ALIGNMENT:
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              country.timezones.length > 1 ? 'TimeZones' : 'Timezone',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: country.timezones
                                  .map((tz) =>
                                      TimeZone(timezone: tz))
                                  .toList(),
                            ),


                            SizedBox(height: 32),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              case CountryDetailsStatus.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
