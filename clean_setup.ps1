If (Test-Path -Path "lib") {
    Remove-Item -Recurse -Force "lib"
}

$folders = @(
    "lib/features/countries_car/domain/entities",
    "lib/features/countries_car/domain/repositories",
    "lib/features/countries_car/domain/usecases",
    "lib/features/countries_car/data/models",
    "lib/features/countries_car/data/datasources/remote",
    "lib/features/countries_car/data/datasources/local",
    "lib/features/countries_car/data/repositories",
    "lib/features/countries_car/presentation/blocs/country_list",
    "lib/features/countries_car/presentation/blocs/country_details",
    "lib/features/countries_car/presentation/blocs/favorites",
    "lib/features/countries_car/presentation/screens",
    "lib/features/countries_car/presentation/widgets",
    "lib/core/error",
    "lib/core/utils",
    "lib/core/network"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

$files = @(
    "lib/features/countries_car/domain/entities/country_summary.dart",
    "lib/features/countries_car/domain/entities/country_details.dart",
    "lib/features/countries_car/domain/repositories/country_repository.dart",
    "lib/features/countries_car/domain/usecases/get_all_countries.dart",
    "lib/features/countries_car/domain/usecases/search_countries.dart",
    "lib/features/countries_car/domain/usecases/get_country_details.dart",
    "lib/features/countries_car/domain/usecases/manage_favorites.dart",
    "lib/features/countries_car/data/models/country_summary_model.dart",
    "lib/features/countries_car/data/models/country_details_model.dart",
    "lib/features/countries_car/data/datasources/remote/country_api_service.dart",
    "lib/features/countries_car/data/datasources/local/favorites_local_storage.dart",
    "lib/features/countries_car/data/repositories/country_repository_impl.dart",
    "lib/features/countries_car/presentation/blocs/country_list/country_list_bloc.dart",
    "lib/features/countries_car/presentation/blocs/country_list/country_list_event.dart",
    "lib/features/countries_car/presentation/blocs/country_list/country_list_state.dart",
    "lib/features/countries_car/presentation/blocs/country_details/country_details_bloc.dart",
    "lib/features/countries_car/presentation/blocs/country_details/country_details_event.dart",
    "lib/features/countries_car/presentation/blocs/country_details/country_details_state.dart",
    "lib/features/countries_car/presentation/blocs/favorites/favorites_bloc.dart",
    "lib/features/countries_car/presentation/blocs/favorites/favorites_event.dart",
    "lib/features/countries_car/presentation/blocs/favorites/favorites_state.dart",
    "lib/features/countries_car/presentation/screens/home_screen.dart",
    "lib/features/countries_car/presentation/screens/search_screen.dart",
    "lib/features/countries_car/presentation/screens/details_screen.dart",
    "lib/features/countries_car/presentation/screens/favorites_screen.dart",
    "lib/features/countries_car/presentation/widgets/country_card.dart",
    "lib/features/countries_car/presentation/widgets/shimmer_loader.dart",
    "lib/features/countries_car/presentation/widgets/error_view.dart",
    "lib/core/network/dio_client.dart",
    "lib/core/network/api_endpoints.dart",
    "lib/core/network/cache_interceptor.dart",
    "lib/main.dart"
)

foreach ($file in $files) {
    New-Item -ItemType File -Force -Path $file | Out-Null
}

Write-Host "Clean Architecture structure created successfully."
