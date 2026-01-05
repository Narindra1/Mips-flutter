import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/empty_list_widget.dart';
import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/constants/constant.dart';
import '../../../common/utils/app_utils.dart';
import '../../../domain/entities/message.dart';
import '../../bloc/app_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/message_displayer_utils.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AppBloc>()..add(LoadUserMessageListEvent()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state.statusMessageDetail == StatusMessageDetail.loading) {
                MessageDisplayerUtils.showLoadingOverlay(context);
              } else if (state.statusMessageDetail ==
                  StatusMessageDetail.loaded) {
                context.pop();
              } else {
                context.pop();
                MessageDisplayerUtils.showToastMessage(
                    context.appLoc.error_operation);
              }
            },
            listenWhen: (previous, current) =>
                previous.statusMessageDetail != current.statusMessageDetail,
            child: BaseScreen(
              appBarAction: [
                Row(children: [
                  if (state.unreadMessageCount > 0)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 40,
                        child: FilledButton(
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)))),
                          onPressed: () {
                            context.read<AppBloc>().add(ViewAllMessageEvent());
                          },
                          child: Text(context.appLoc.read_all),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: smallPadding,
                  )
                ])
              ],
              content: RefreshIndicator(
                child: _buildContent(context, state),
                onRefresh: () async {
                  context.read<AppBloc>().add(LoadUserMessageListEvent());
                },
              ),
              // title: Text(
              //     "${context.appLoc.messages_screen_title} (${state.unreadMessageCount})")),
              title: Text(
                "${context.appLoc.notifications} (${state.unreadMessageCount})",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Ionicons.chevron_back,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppState state) {
    Widget content = const SizedBox();
    if (state.statusMessage == StatusMessage.error) {
      content = const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Center(
                child: ErrorPageWidget(),
              ),
            ),
          ]);
    } else {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (state.userMessageList.isEmpty &&
                state.statusMessage == StatusMessage.loaded)
              const Center(
                child: EmptyListWidget(
                  listType: ListType.message,
                ),
              ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.userMessageList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  _buildMessageTile(context, state.userMessageList[index]),
            ),
            if (state.statusMessage == StatusMessage.loading)
              Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: AppLoadingWidget(
                  size: state.userMessageList.isEmpty ? 36 : 24,
                ),
              ),
            if (state.userMessageList.isNotEmpty &&
                state.isNextMessageListAvailable &&
                state.statusMessage == StatusMessage.loaded)
              Padding(
                  padding: const EdgeInsets.all(smallPadding),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: () {
                        context.read<AppBloc>().add(LoadMoreMessageEvent());
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      label: Text(context.appLoc.load_more_messages),
                    ),
                  ))
          ],
        ),
      );
    }
    return content;
  }

  Widget _buildMessageTile(BuildContext context, Message message) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(mediumPadding),
            border: Border.all(
                color: !message.isViewed
                    ? tertiaryColor.withAlpha(175)
                    : Colors.grey.shade300,
                width: 1)),
        child: ListTile(
          onTap: message.isViewed
              ? null
              : () {
                  context.read<AppBloc>().add(ViewMessageEvent(id: message.id));
                },
          titleTextStyle: Theme.of(context).textTheme.titleSmall,
          subtitleTextStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey.shade600),
          isThreeLine: true,
          title: Row(
            children: [
              Expanded(
                  child: Text(
                message.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
              if (message.isViewed)
                const Text(
                  "✓",
                  style: TextStyle(color: Colors.grey),
                ),
              if (!message.isViewed)
                Container(
                  width: mediumPadding,
                  height: mediumPadding,
                  padding: const EdgeInsets.all(smallPadding),
                  decoration: BoxDecoration(
                      color: tertiaryColor,
                      borderRadius: BorderRadius.circular(mediumPadding)),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppUtils.formatDateReadableWithMonth(
                          context, message.date),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
