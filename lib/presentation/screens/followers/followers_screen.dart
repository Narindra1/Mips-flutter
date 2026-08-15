import 'package:mips/domain/entities/user.dart';
import 'package:mips/presentation/bloc/follow_bloc.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:mips/presentation/screens/followers/widgets/user_follow.dart';
import 'package:mips/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: BlocProvider(
        create: (context) => GetIt.instance<FollowBloc>()
          ..add(FollowersLoadedEvent())
          ..add(FollowingLoadedEvent()),
        child: Column(
          children: [
            TabBar.secondary(
              controller: _tabController,
              labelStyle: textTheme.titleMedium,
              unselectedLabelStyle: textTheme.titleMedium,
              dividerColor: Colors.grey,
              indicatorColor: secondaryColor,
              tabs: [
                BlocBuilder<FollowBloc, FollowState>(
                  builder: (context, state) {
                    return Tab(
                      text:
                          "${context.appLoc.followers} (${state.myFollowers.length})",
                    );
                  },
                ),
                BlocBuilder<FollowBloc, FollowState>(
                  builder: (context, state) {
                    return Tab(
                      text:
                          "${context.appLoc.followings} (${state.myFollowings.length})",
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<FollowBloc, FollowState>(
                    builder: (context, state) {
                      if (state.followersStatus == FollowersStatus.loading) {
                        return AppLoadingWidget();
                      } else if (state.followersStatus ==
                          FollowersStatus.loaded) {
                        if (state.myFollowers.isNotEmpty) {
                          List<User> followers = state.myFollowers;
                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<FollowBloc>().add(
                                FollowersLoadedEvent(),
                              );
                            },
                            child: ListView.separated(
                              key: PageStorageKey('my_followers_list'),
                              itemBuilder: (context, index) => UserFollow(
                                key: ValueKey("my_followers_$index"),
                                user: followers[index],
                              ),
                              separatorBuilder: (context, index) => Divider(
                                indent: 5,
                                endIndent: 5,
                                color: Colors.grey.shade200,
                              ),
                              itemCount: followers.length,
                            ),
                          );
                        }
                      }
                      return EmptyListWidget(listType: ListType.followers);
                    },
                  ),
                  BlocBuilder<FollowBloc, FollowState>(
                    builder: (context, state) {
                      if (state.followingStatus == FollowingStatus.loading) {
                        return AppLoadingWidget();
                      } else if (state.followingStatus ==
                          FollowingStatus.loaded) {
                        if (state.myFollowings.isNotEmpty) {
                          List<User> followings = state.myFollowings;
                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<FollowBloc>().add(
                                FollowingLoadedEvent(),
                              );
                            },
                            child: ListView.separated(
                              key: PageStorageKey('my_followings_list'),
                              itemBuilder: (context, index) => UserFollow(
                                key: ValueKey("my_followings_$index"),
                                user: followings[index],
                              ),
                              separatorBuilder: (context, index) => Divider(
                                indent: 5,
                                endIndent: 5,
                                color: Colors.grey.shade200,
                              ),
                              itemCount: followings.length,
                            ),
                          );
                        }
                      }
                      return EmptyListWidget(listType: ListType.followings);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      title: Text(
        context.appLoc.followers,
        style: TextStyle(fontFamily: "Pretendard", color: Colors.black),
      ),
    );
  }
}
