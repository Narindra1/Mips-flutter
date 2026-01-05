import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/services/global_context_service.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class KaraSubscription extends StatelessWidget {
  const KaraSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<KaraPartnerBloc>(),
      child: Builder(builder: (context) {
        return BaseScreen(
          useDefaultAnnonceSponsPart: true,
          title: Text(
            context.appLoc.become_kara_partner,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  // color: Colors.green,
                  child: SvgPicture.asset("assets/imgs/illu_kara_partner.svg"),
                ),
                SizedBox(height: largePadding),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: () {
                      context
                          .read<KaraPartnerBloc>()
                          .add(KaraSubscriptionLoaded());
                    },
                    child: BlocConsumer<KaraPartnerBloc, KaraPartnerState>(
                      listener: (context, state) {
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.sent) {
                          MessageDisplayerUtils.showToastMessage(
                              GlobalContextService.snackbarKey.currentContext!
                                  .appLoc.request_successfully_sent);
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        print("STATE : ${state.karaSubscriptionStatus}");
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.sending) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              AppLoadingWidget(
                                size: 12,
                                color: Colors.white,
                              ),
                              Text(
                                context.appLoc.submit_your_request,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )
                            ],
                          );
                        }
                        return Text(context.appLoc.submit_your_request);
                      },
                    ),
                  ),
                ),
              ],
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
          backgroundColor: Colors.white,
        );
      }),
    );
  }
}
