import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../common/constants/constant.dart';
import '../bloc/annonce_bloc.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  final bool onSearch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AnnonceBloc>(context),
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(vertical: smallPadding),
        child: TextField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: TextEditingController()
            ..text = context.read<AnnonceBloc>().state.query,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: const Icon(Ionicons.search_outline),
            contentPadding: const EdgeInsets.only(
                left: mediumPadding,
                top: mediumPadding,
                right: mediumPadding,
                bottom: mediumPadding),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(largePadding),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(largePadding),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(largePadding),
            ),
            hintText: hintText,
          ),
          onChanged: (query) {},
          onSubmitted: (query) {
            onSearch
                ? context
                    .read<AnnonceBloc>()
                    .add(QuerySubmitedListRecentAnnonceEvent(query: query))
                : context
                    .read<AnnonceBloc>()
                    .add(QuerySubmitedListAnnonceEvent(query: query));
          },
        ),
      ),
    );
  }

  const AppSearchBar({
    super.key,
    this.onSearch = false,
    required this.hintText,
  });
}
