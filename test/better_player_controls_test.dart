import 'package:better_player/better_player.dart';
import 'package:better_player/src/controls/better_player_cupertino_progress_bar.dart';
import 'package:better_player/src/core/better_player_with_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'better_player_mock_controller.dart';

void main() {
  late BetterPlayerMockController _mockController;

  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  setUp(() {
    _mockController =
        BetterPlayerMockController(const BetterPlayerConfiguration());
  });

  testWidgets(
    "One of children is BetterPlayerWithControls",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          BetterPlayer(
            controller: _mockController,
          ),
        ),
      );
      expect(
          find.byWidgetPredicate(
              (widget) => widget is BetterPlayerWithControls),
          findsOneWidget);
    },
  );

  testWidgets(
    "Controls should changed based on isFullscreen state",
    (WidgetTester tester) async {
      final BetterPlayerMockController betterPlayerMockController =
          BetterPlayerMockController(
              const BetterPlayerConfiguration(
                fullScreenByDefault: false,
                controlsConfiguration: BetterPlayerControlsConfiguration(
                  enableProgressBar: true,
                ),
                controlsConfigurationFullScreen:
                    BetterPlayerControlsConfiguration(
                  enableProgressBar: false,
                ),
              ),
              betterPlayerDataSource: BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', //we should have a video to render controls
              ));
      expect(betterPlayerMockController.isFullScreen, false);
      await tester.pumpWidget(
        _wrapWidget(
          BetterPlayer(
            controller: betterPlayerMockController,
          ),
        ),
      );
      expect(
          find.byWidgetPredicate((widget) =>
              widget is BetterPlayerCupertinoVideoProgressBar ||
              widget is BetterPlayerMaterialVideoProgressBar),
          findsOneWidget);
      betterPlayerMockController.enterFullScreen();

      await tester.pump();
      expect(
          find.byWidgetPredicate((widget) =>
              widget is BetterPlayerCupertinoVideoProgressBar ||
              widget is BetterPlayerMaterialVideoProgressBar),
          findsNothing);
    },
  );
}

///Wrap widget with material app to handle all features like navigation and
///localization properly.
Widget _wrapWidget(Widget widget) {
  return MaterialApp(home: widget);
}
