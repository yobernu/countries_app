flutter create --project-name countries_app --org com.example .

$folders = @(
    "lib/core/constants",
    "lib/core/utils",
    "lib/core/error",
    "lib/core/network",
    "lib/data/models",
    "lib/data/repositories",
    "lib/data/local",
    "lib/logic/blocs/country_list",
    "lib/logic/blocs/country_details",
    "lib/logic/blocs/favorites",
    "lib/logic/cubits",
    "lib/presentation/screens",
    "lib/presentation/widgets",
    "lib/presentation/themes"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

$files = @(
    "lib/core/network/dio_client.dart",
    "lib/core/network/api_endpoints.dart",
    "lib/core/network/cache_interceptor.dart",
    "lib/data/models/country_summary.dart",
    "lib/data/models/country_details.dart",
    "lib/data/repositories/country_repository.dart",
    "lib/data/local/hive_manager.dart",
    "lib/logic/blocs/country_list/country_list_bloc.dart",
    "lib/logic/blocs/country_list/country_list_event.dart",
    "lib/logic/blocs/country_list/country_list_state.dart",
    "lib/logic/blocs/country_details/country_details_bloc.dart",
    "lib/logic/blocs/country_details/country_details_event.dart",
    "lib/logic/blocs/country_details/country_details_state.dart",
    "lib/logic/blocs/favorites/favorites_bloc.dart",
    "lib/logic/blocs/favorites/favorites_event.dart",
    "lib/logic/blocs/favorites/favorites_state.dart",
    "lib/logic/cubits/theme_cubit.dart",
    "lib/presentation/screens/home_screen.dart",
    "lib/presentation/screens/search_screen.dart",
    "lib/presentation/screens/details_screen.dart",
    "lib/presentation/screens/favorites_screen.dart",
    "lib/presentation/widgets/country_card.dart",
    "lib/presentation/widgets/shimmer_loader.dart",
    "lib/presentation/widgets/error_view.dart",
    "lib/presentation/themes/app_theme.dart"
)

foreach ($file in $files) {
    New-Item -ItemType File -Force -Path $file | Out-Null
}

flutter pub add flutter_bloc dio hive hive_flutter equatable shimmer dio_http_cache cached_network_image go_router get_it path_provider json_annotation
flutter pub add -d build_runner json_serializable hive_generator
