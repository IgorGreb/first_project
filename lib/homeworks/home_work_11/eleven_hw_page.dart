import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/bloc/get_post_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/bloc/get_post_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/bloc/get_post_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/constants/eleven_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/comment_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/post_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/services/post_remote_data_source.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevenHwPage extends StatelessWidget {
  const ElevenHwPage({super.key});

  static const routeName = '/homework-eleven';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetPostBloc(postRemoteDataSource: PostRemoteDataSource())
                ..add(const GetPostsRequested()),
      child: const AppScaffold(title: ElevenTexts.title, body: _PostsBody()),
    );
  }
}

class _PostsBody extends StatelessWidget {
  const _PostsBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ElevenDimens.pagePaddingHorizontal,
          vertical: ElevenDimens.pagePaddingVertical,
        ),
        child: BlocListener<GetPostBloc, GetPostState>(
          listenWhen:
              (previous, current) =>
                  previous.notificationMessage != current.notificationMessage &&
                  current.notificationMessage != null,
          listener: (context, state) {
            final message = state.notificationMessage;
            if (message == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
            context.read<GetPostBloc>().add(const PostActionMessageCleared());
          },
          child: BlocBuilder<GetPostBloc, GetPostState>(
            builder: (context, state) {
              Widget header = const SizedBox.shrink();
              Widget body;

              switch (state.status) {
                case GetPostStatus.initial:
                case GetPostStatus.loadingPosts:
                  body = const _CenteredLoader();
                  break;
                case GetPostStatus.failure:
                  body = _FailureView(
                    message: state.errorMessage ?? ElevenTexts.genericError,
                  );
                  break;
                case GetPostStatus.postsLoaded:
                case GetPostStatus.loadingComments:
                  header = const _SectionHeader(
                    title: ElevenTexts.postsHeader,
                    subtitle: ElevenTexts.postsSubtitle,
                  );
                  body = _PostsList(
                    posts: state.posts,
                    selectedPostId: state.selectedPostId,
                    isLoadingComments:
                        state.status == GetPostStatus.loadingComments,
                    deletingPostIds: state.deletingPostIds,
                  );
                  break;
                case GetPostStatus.commentsLoaded:
                  header = _SectionHeader(
                    title: ElevenTexts.commentsHeader,
                    subtitle:
                        '${ElevenTexts.commentsHint}${state.selectedPostId ?? '-'}',
                    action: TextButton.icon(
                      onPressed:
                          () => context.read<GetPostBloc>().add(
                            const CommentsViewClosed(),
                          ),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(ElevenTexts.backToPosts),
                    ),
                  );
                  body = _CommentsView(
                    postId: state.selectedPostId,
                    comments: state.comments,
                  );
                  break;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  const SizedBox(height: ElevenDimens.spaceMD),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: ElevenDurations.contentSwitch,
                      child: body,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.subtitle, this.action});

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              if (subtitle != null) ...[
                const SizedBox(height: ElevenDimens.spaceXS),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class _PostsList extends StatelessWidget {
  const _PostsList({
    required this.posts,
    required this.selectedPostId,
    required this.isLoadingComments,
    required this.deletingPostIds,
  });

  final List<PostModel> posts;
  final int? selectedPostId;
  final bool isLoadingComments;
  final Set<int> deletingPostIds;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const _IllustratedMessage(
        icon: Icons.chrome_reader_mode_outlined,
        message: ElevenTexts.postsEmpty,
      );
    }

    final listView = RefreshIndicator(
      onRefresh: () async {
        context.read<GetPostBloc>().add(const GetPostsRequested());
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: posts.length,
        separatorBuilder:
            (_, __) => const SizedBox(height: ElevenDimens.spaceMD),
        itemBuilder: (_, index) {
          final post = posts[index];
          final postId = post.id;
          final isSelected = postId != null && postId == selectedPostId;
          final isDeleting = postId != null && deletingPostIds.contains(postId);

          return Card(
            elevation: isSelected ? 4 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ElevenDimens.cardRadius),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(ElevenDimens.cardRadius),
              onTap:
                  postId == null || isDeleting
                      ? null
                      : () => context.read<GetPostBloc>().add(
                        GetPostCommentsRequested(postId: postId),
                      ),
              child: Padding(
                padding: const EdgeInsets.all(ElevenDimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title ?? ElevenTexts.postEmptyTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: ElevenFontWeights.cardTitle,
                      ),
                    ),
                    const SizedBox(height: ElevenDimens.spaceSM),
                    Text(post.body ?? ''),
                    const SizedBox(height: ElevenDimens.spaceMD),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${ElevenTexts.postIdLabel}${postId ?? ElevenTexts.placeholderDash}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isDeleting)
                              const SizedBox(
                                width: ElevenDimens.deletingIndicatorSize,
                                height: ElevenDimens.deletingIndicatorSize,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            else
                              IconButton(
                                tooltip: ElevenTexts.deleteButtonTooltip,
                                onPressed:
                                    postId == null
                                        ? null
                                        : () => context.read<GetPostBloc>().add(
                                          DeletePostRequested(postId: postId),
                                        ),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            const SizedBox(width: ElevenDimens.spaceXS),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: ElevenDimens.iconSmall,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (!isLoadingComments) return listView;

    return Stack(
      children: [
        listView,
        Container(
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(ElevenDimens.overlayOpacity),
            borderRadius: BorderRadius.circular(ElevenDimens.cardRadius),
          ),
          child: const _CenteredLoader(),
        ),
      ],
    );
  }
}

class _CommentsView extends StatelessWidget {
  const _CommentsView({required this.postId, required this.comments});

  final int? postId;
  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const _IllustratedMessage(
        icon: Icons.chat_bubble_outline,
        message: ElevenTexts.commentsEmpty,
      );
    }

    return ListView.separated(
      itemCount: comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: ElevenDimens.spaceMD),
      itemBuilder: (_, index) {
        final comment = comments[index];
        final email = comment.email?.trim() ?? '';
        final avatarSource =
            email.isEmpty ? ElevenTexts.avatarFallback : email[0];
        final avatarLetter = avatarSource.toUpperCase();
        final emailLabel = email.isEmpty ? ElevenTexts.missingEmail : email;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ElevenDimens.cardRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ElevenDimens.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(child: Text(avatarLetter)),
                    const SizedBox(width: ElevenDimens.spaceMD),
                    Expanded(
                      child: Text(
                        emailLabel,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ElevenDimens.spaceMD),
                Text(comment.body ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CenteredLoader extends StatelessWidget {
  const _CenteredLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _IllustratedMessage extends StatelessWidget {
  const _IllustratedMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ElevenDimens.iconPlaceholder,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: ElevenDimens.spaceMD),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi_off, size: ElevenDimens.iconFailure),
        const SizedBox(height: ElevenDimens.spaceMD),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: ElevenDimens.spaceLG),
        ElevatedButton.icon(
          onPressed: () {
            context.read<GetPostBloc>().add(const GetPostsRequested());
          },
          icon: const Icon(Icons.refresh),
          label: const Text(ElevenTexts.retry),
        ),
      ],
    );
  }
}
