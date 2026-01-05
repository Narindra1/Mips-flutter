import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../bloc/app_bloc.dart';
import '../../widgets/app_panel_widget.dart';
import '../../widgets/ota_progress_dialog.dart';

/// Écran d'information "À propos" de l'application.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(largePadding),
        child: AppPanelWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/imgs/ic_mahafaka.png',
                  height: 82,
                  width: 82,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      context.appLoc.app_name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: smallPadding),
                    Text(
                      context.read<AppBloc>().appVersion,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    if (context.read<AppBloc>().state.updateStatus ==
                        UpdateStatus.updateVersionAvailable)
                      Column(
                        children: [
                          const SizedBox(height: mediumPadding),
                          Text(context.appLoc.new_version_available(
                              context.read<AppBloc>().updateVersion)),
                          const SizedBox(height: smallPadding),
                          FilledButton(
                              onPressed: () async {
                                // UriUtils.trylaunchUrl(urlDownloadAppUpdate)
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) =>
                                      const OtaProgressDialog(),
                                );
                              },
                              child: Text(context.appLoc.update))
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: largePadding * 2),
              // A propos de L'application
              Text(
                context.appLoc.setting_about_app_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: mediumPadding),
              Text(
                context.appLoc.setting_about_app_desc1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: mediumPadding),
              Text(
                context.appLoc.setting_about_app_desc2,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: largePadding * 2),
              // Propriété intellectuelle
              Text(
                context.appLoc.setting_about_propriete_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: mediumPadding),
              Text(
                context.appLoc.setting_about_propriete_annonce_text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: largePadding * 2),
              // Collecte de Données et Confidentialité
              Text(
                context.appLoc.setting_about_propriete_data_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: mediumPadding),
              Text(
                context.appLoc.setting_about_propriete_data_text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: largePadding * 2),
              // Contact
              Text(
                context.appLoc.setting_about_propriete_contact_title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: mediumPadding),
              Text(
                context.appLoc.setting_about_propriete_contact_text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: largePadding * 2),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Icons by Icons8",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        context.appLoc.setting_about,
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
    );
  }
}
