import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_styles.dart';
import 'package:just_audio/just_audio.dart';

class HomeworkAudioCard extends StatefulWidget {
  const HomeworkAudioCard({super.key});

  @override
  State<HomeworkAudioCard> createState() => _HomeworkAudioCardState();
}

class _HomeworkAudioCardState extends State<HomeworkAudioCard> {
  static const String _audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isLoopEnabled = true;
  double _volume = 0.6;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      await _audioPlayer.setUrl(_audioUrl);
      await _audioPlayer.setVolume(_volume);
      await _audioPlayer.setLoopMode(LoopMode.one);
    } catch (error) {
      setState(() => _error = '${Homework14Texts.audioErrorPrefix}$error');
    }
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_audioPlayer.playerState.processingState == ProcessingState.loading) {
      return;
    }

    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {});
  }

  void _seekTo(double milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds.round()));
  }

  void _updateVolume(double value) {
    setState(() => _volume = value);
    _audioPlayer.setVolume(value);
  }

  void _toggleLoopMode(bool value) {
    setState(() => _isLoopEnabled = value);
    _audioPlayer.setLoopMode(value ? LoopMode.one : LoopMode.off);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Homework14Dimensions.cardBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Homework14Dimensions.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Homework14Texts.audioCardTitle,
              style: Homework14TextStyles.sectionTitle,
            ),
            const SizedBox(height: Homework14Dimensions.tinySpacing),
            Text(
              Homework14Texts.audioCardDescription,
              style: Homework14TextStyles.body,
            ),
            if (_error != null) ...[
              const SizedBox(height: Homework14Dimensions.sliderSpacing),
              Text(
                _error!,
                style: Homework14TextStyles.body
                    .copyWith(color: colorScheme.error),
              ),
            ],
            const SizedBox(height: Homework14Dimensions.infoSpacing),
            _AudioProgress(player: _audioPlayer),
            const SizedBox(height: Homework14Dimensions.sliderSpacing),
            Wrap(
              spacing: Homework14Dimensions.wrapSpacing,
              runSpacing: Homework14Dimensions.wrapSpacing,
              children: [
                _AudioButton(
                  icon: _audioPlayer.playing
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  label: _audioPlayer.playing
                      ? Homework14Texts.audioPause
                      : Homework14Texts.audioPlay,
                  onPressed: _togglePlay,
                ),
                _AudioButton(
                  icon: Icons.stop_rounded,
                  label: Homework14Texts.audioRestart,
                  onPressed: () => _seekTo(0),
                ),
              ],
            ),
            const SizedBox(height: Homework14Dimensions.audioBlockSpacing),
            Text(
              '${Homework14Texts.audioVolumePrefix}${(_volume * 100).round()}%',
              style: Homework14TextStyles.body,
            ),
            Slider(
              value: _volume,
              max: 1,
              divisions: 20,
              label: (_volume * 100).round().toString(),
              onChanged: _updateVolume,
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                Homework14Texts.audioLoopTitle,
                style: Homework14TextStyles.body,
              ),
              subtitle: Text(
                Homework14Texts.audioLoopSubtitle,
                style: Homework14TextStyles.caption,
              ),
              value: _isLoopEnabled,
              onChanged: _toggleLoopMode,
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioButton extends StatelessWidget {
  const _AudioButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.secondary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(
        Homework14Dimensions.buttonBorderRadius,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          Homework14Dimensions.buttonBorderRadius,
        ),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Homework14Dimensions.buttonPaddingHorizontal,
            vertical: Homework14Dimensions.buttonPaddingVertical,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: colorScheme.secondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: Homework14TextStyles.body.copyWith(
                  color: colorScheme.secondary,
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

class _AudioProgress extends StatelessWidget {
  const _AudioProgress({required this.player});

  final AudioPlayer player;

  String _format(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final captionStyle = Homework14TextStyles.caption.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
    );

    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, durationSnapshot) {
        final Duration total = durationSnapshot.data ?? Duration.zero;
        final double maxValue =
            total.inMilliseconds == 0 ? 1 : total.inMilliseconds.toDouble();

        return StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, positionSnapshot) {
            final Duration position = positionSnapshot.data ?? Duration.zero;
            final double sliderValue =
                position.inMilliseconds.clamp(0, maxValue).toDouble();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  min: 0,
                  max: maxValue,
                  value: sliderValue,
                  onChanged: (value) => player.seek(
                    Duration(milliseconds: value.round()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_format(position), style: captionStyle),
                    Text(_format(total), style: captionStyle),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
