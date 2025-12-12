import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_styles.dart';
import 'package:video_player/video_player.dart';

class HomeworkVideoCard extends StatefulWidget {
  const HomeworkVideoCard({super.key});

  @override
  State<HomeworkVideoCard> createState() => _HomeworkVideoCardState();
}

class _HomeworkVideoCardState extends State<HomeworkVideoCard> {
  late final VideoPlayerController _controller;
  late final Future<void> _initFuture;
  bool _isFilterEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/sample.mp4');
    _initFuture = _controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_controller.value.isInitialized) {
      return;
    }
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {});
  }

  void _restart() {
    if (!_controller.value.isInitialized) {
      return;
    }
    _controller.seekTo(Duration.zero);
    setState(() {});
  }

  void _pause() {
    if (!_controller.value.isInitialized) {
      return;
    }
    _controller.pause();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Локальне відео', style: Homework14TextStyles.sectionTitle),
            const SizedBox(height: 6),
            Text(
              'Файл з каталогу проєкту відтворюється за допомогою video_player.',
              style: Homework14TextStyles.body,
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: FutureBuilder<void>(
                future: _initFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  Widget video = AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );

                  if (_isFilterEnabled) {
                    video = ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Homework14Colors.accent.withValues(alpha: 0.2),
                        BlendMode.softLight,
                      ),
                      child: video,
                    );
                  }

                  return video;
                },
              ),
            ),
            const SizedBox(height: 16),
            if (_controller.value.isInitialized)
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: colorScheme.primary,
                  bufferedColor: colorScheme.primary.withValues(alpha: 0.3),
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                _ControlButton(
                  icon: Icons.play_arrow_rounded,
                  label: 'Відтворити',
                  onPressed: _togglePlay,
                  isActive: _controller.value.isPlaying,
                ),
                _ControlButton(
                  icon: Icons.pause_rounded,
                  label: 'Пауза',
                  onPressed: _pause,
                ),
                _ControlButton(
                  icon: Icons.replay_rounded,
                  label: 'На початок',
                  onPressed: _restart,
                ),
              ],
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Підсвітити відео через ColorFiltered',
                style: Homework14TextStyles.body,
              ),
              value: _isFilterEnabled,
              onChanged: (value) => setState(() => _isFilterEnabled = value),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: isActive
          ? colorScheme.primary
          : colorScheme.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? colorScheme.onPrimary : colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Homework14TextStyles.body.copyWith(
                  color: isActive ? colorScheme.onPrimary : colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
