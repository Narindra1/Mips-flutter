import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widget/avatar_card_widget.dart';
import 'bloc/avatar_bloc.dart';

class AchatAvatarScreen extends StatelessWidget {
  const AchatAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: BlocProvider(
        create: (context) =>
            GetIt.instance<AvatarBloc>()..add(LoadAvatarListEvent()),
        child: BlocBuilder<AvatarBloc, AvatarState>(
          builder: (context, state) {
            Widget content = const SizedBox();
            if (state.status == Status.loading) {
              content = const Center(
                child: AppLoadingWidget(),
              );
            } else if (state.status == Status.loaded) {
              content = GridView.builder(
                itemCount: state.avatarList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250, // Maximum width for each grid item
                  // Spacing between items vertically
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  return AvatarCardWidget(avatar: state.avatarList[index]);
                },
              );
            } else {
              content = const CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      child: Center(
                        child: ErrorPageWidget(),
                      ),
                    ),
                  ]);
            }
            return RefreshIndicator(
                onRefresh: () async {
                  context.read<AvatarBloc>().add(LoadAvatarListEvent());
                },
                child: content);
          },
        ),
      ),
      title: Text(
        context.appLoc.avatar,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
    );
  }
}
