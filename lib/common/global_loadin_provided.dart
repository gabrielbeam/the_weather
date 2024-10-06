import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:the_weather/common/weather_text.dart';

class GlobalLoadingNotifier extends StateNotifier<LoadingProviderState> {
  GlobalLoadingNotifier({required bool? loading}) : super(LoadingProviderState(loading: false));

  showLoading({Widget? text}) {
    state = LoadingProviderState(
      loading: true,
      text: text,
    );
  }

  hideLoading() {
    state = LoadingProviderState(
      loading: false,
      text: null,
    );
  }
}

final globalLoadingProvider = StateNotifierProvider<GlobalLoadingNotifier, LoadingProviderState>(
  (ref) => GlobalLoadingNotifier(loading: false),
);

class LoadingProviderState {
  bool loading;
  Widget? text;
  LoadingProviderState({required this.loading, this.text});
}

Widget overlay({Widget? text}) {
  return Container(
    color: Colors.transparent,
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animate/loader.json',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 20),
        if (text != null) ...[
          text
        ] else ...[
          WeatherText.body(
            'Loading...',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            overflow: TextOverflow.clip,
          )
        ]
      ],
    ),
  );
}
