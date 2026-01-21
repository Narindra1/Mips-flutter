import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/mips_info/bloc/mips_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class MipsInfoScreen extends StatelessWidget {
  const MipsInfoScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<MipsInfoBloc>()..add(LoadMipsInfoListEvent()),
      child: BaseScreen(
        useDefaultAnnonceSponsPart: true,
        content: BlocBuilder<MipsInfoBloc, MipsInfoState>(
          builder: (context, state) {
            Widget content = SizedBox();
            if (state.mipsInfoStatus == MipsInfoStatus.loading) {
              content = AppLoadingWidget();
            } else if (state.mipsInfoStatus == MipsInfoStatus.loaded) {
              content = SingleChildScrollView(
                padding: EdgeInsets.all(mediumPadding),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.avisList.isEmpty
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.appLoc.survey_results,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: mediumPadding),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.avisList.length,
                                itemBuilder: (context, index) {
                                  return MaterialButton(
                                    child: Text(
                                      state.avisList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: tertiaryColor,
                                          ),
                                    ),
                                    onPressed: () {
                                      AppRouter.go(
                                        context,
                                        RoutesNames.avisDetail,
                                        queryParameters: {
                                          "id": state.avisList[index].id
                                              .toString(),
                                          "title": state.avisList[index].title,
                                          "pageUrl":
                                              state.avisList[index].htmlURL
                                        },
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Divider(
                                        color: Colors.grey.shade400,
                                        indent: 50,
                                        endIndent: 15,
                                      ),
                                      const SizedBox(height: smallPadding),
                                    ],
                                  );
                                },
                              ),
                            ],
                          )
                  ],
                ),
              );
            }
            return RefreshIndicator(
              child: content,
              onRefresh: () async {
                context.read<MipsInfoBloc>().add(LoadMipsInfoListEvent());
              },
            );
          },
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Pretendard",
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
    );
  }
}
