import 'package:mips/common/constants/constant.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:mips/presentation/screens/mips_info/bloc/mips_info_bloc.dart';
import 'package:mips/presentation/widgets/empty_list_widget.dart';
import 'package:mips/presentation/widgets/more_info_widget.dart';
import 'package:mips/presentation/widgets/sondage_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MipsInfoScreen extends StatelessWidget {
  const MipsInfoScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MipsInfoBloc>()
        ..add(LoadMipsInfoListEvent())
        ..add(LoadMoreInfoListEvent()),
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
                    state.avisList.isEmpty && state.moreInfoList.isEmpty
                        ? EmptyListWidget(listType: ListType.news)
                        : SizedBox(),
                    state.avisList.isEmpty
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.appLoc.survey_results,
                                style: Theme.of(context).textTheme.titleMedium!
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
                                    child: SondageInfoWidget(
                                      title: state.avisList[index].title,
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
                                              state.avisList[index].htmlURL,
                                        },
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: mediumPadding);
                                },
                              ),
                            ],
                          ),
                    const SizedBox(height: largePadding),
                    state.moreInfoList.isEmpty
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.appLoc.more_informations,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: mediumPadding),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.moreInfoList.length,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: mediumPadding,
                                ),
                                itemBuilder: (context, index) {
                                  return MoreInfoWidget(
                                    title: state.moreInfoList[index].title,
                                    content: state.moreInfoList[index].content,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: mediumPadding);
                                },
                              ),
                            ],
                          ),
                    const SizedBox(height: largePadding),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              child: content,
              onRefresh: () async {
                context.read<MipsInfoBloc>()
                  ..add(LoadMipsInfoListEvent())
                  ..add(LoadMoreInfoListEvent());
              },
            );
          },
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: "Pretendard", color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
