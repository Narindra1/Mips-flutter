import 'package:mips/common/common.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_widget.dart';
import 'bloc/avis_bloc.dart';

class AvisListScreen extends StatelessWidget {
  final String title;

  const AvisListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AvisBloc>()..add(LoadListEvent()),
      child: BaseScreen(
        title: Text(title),
        content: BlocBuilder<AvisBloc, AvisState>(
          builder: (context, state) {
            Widget content = const SizedBox();
            if (state.status == Status.loading) {
              content = const Center(child: AppLoadingWidget());
            } else if (state.status == Status.loaded) {
              content = Padding(
                padding: const EdgeInsets.only(
                  left: mediumPadding,
                  right: mediumPadding,
                ),
                child: ListView.builder(
                  itemCount: state.avisList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index - 1 >= 0 &&
                            state.avisList[index - 1].avisType ==
                                AvisType.avisInfo &&
                            state.avisList[index].avisType == AvisType.normal)
                          Divider(color: Colors.grey.shade400, thickness: 4),
                        Container(
                          margin: EdgeInsets.only(
                            top: index == 0 ? smallPadding : smallPadding / 2,
                            bottom: smallPadding / 2,
                          ),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(mediumPadding),
                            border: Border.all(color: Colors.grey.shade400),
                            color: Colors.white,
                          ),
                          child: ListTile(
                            onTap: () {
                              AppRouter.go(
                                context,
                                RoutesNames.avisDetail,
                                queryParameters: {
                                  "id": state.avisList[index].id.toString(),
                                  "title": state.avisList[index].title,
                                  "pageUrl": state.avisList[index].htmlURL,
                                },
                              );
                            },
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.avisList[index].title,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  AppUtils.formatDateMin(
                                    state.avisList[index].dateUpdate,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              content = const CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(child: Center(child: ErrorPageWidget())),
                ],
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<AvisBloc>().add(LoadListEvent());
              },
              child: content,
            );
          },
        ),
      ),
    );
  }
}
