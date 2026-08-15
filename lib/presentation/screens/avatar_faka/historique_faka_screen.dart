import 'package:mips/common/common.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_widget.dart';
import '../base/base_screen.dart';

class HistoriqueFakaScreen extends StatelessWidget {
  const HistoriqueFakaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AppBloc>()..add(LoadHistoryFakaChangeEvent(page: 1)),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          Widget content = const SizedBox();
          if (state.historyFakaListStatus == HistoryFakaListStatus.loading) {
            content = const Center(child: AppLoadingWidget());
          } else if (state.historyFakaListStatus ==
              HistoryFakaListStatus.loaded) {
            content = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.transactionHistory.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // color: Colors.amber,
                      // margin: EdgeInsets.all(smallPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(mediumPadding),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        titleTextStyle: Theme.of(context).textTheme.titleSmall,
                        subtitleTextStyle: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: Colors.grey.shade600),
                        isThreeLine: true,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.transactionHistory[index].type,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(smallPadding),
                              decoration: BoxDecoration(
                                color: !state.transactionHistory[index].isIncome
                                    ? Colors.red.shade400
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(
                                  mediumPadding,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    width: 24,
                                    height: 24,
                                    mipsCoin,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: smallPadding),
                                  Text(
                                    "${state.transactionHistory[index].isIncome ? "+" : "-"}${state.transactionHistory[index].montantFaka}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.transactionHistory[index].message,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppUtils.formatDateReadableWithMonth(
                                      context,
                                      state.transactionHistory[index].date,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
          return BaseScreen(
            content: RefreshIndicator(
              child: content,
              onRefresh: () async {
                context.read<AppBloc>().add(
                  LoadHistoryFakaChangeEvent(page: 1),
                );
              },
            ),
            title: Text(context.appLoc.faka_history),
          );
        },
      ),
    );
  }
}
