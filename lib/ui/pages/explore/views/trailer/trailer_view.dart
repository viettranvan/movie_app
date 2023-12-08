import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  const TrailerView({super.key});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrailerBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          final trailerBloc = BlocProvider.of<TrailerBloc>(context);
          final exploreBloc = BlocProvider.of<ExploreBloc>(context);
          switch (state.runtimeType) {
            case NavigationSuccess:
              state.indexPage == 1
                  ? trailerBloc.state is TrailerSuccess
                      ? exploreBloc.scrollController.position.extentBefore <= 50
                          ? trailerBloc.state.visibleVideoMovie[trailerBloc.state.indexMovie] ||
                                  trailerBloc.state.visibleVideoTv[trailerBloc.state.indexTv]
                              ? null
                              : debouncer.slowCall(() => autoPlayTrailer(context))
                          : debouncer.slowCall(() => stopTrailer(context))
                      : debouncer.slowCall(() => stopTrailer(context))
                  : debouncer.slowCall(() => stopTrailer(context));
              break;
            case NavigationScrollSuccess:
              state.indexPage == 1
                  ? trailerBloc.state is TrailerSuccess
                      ? trailerBloc.state.visibleVideoMovie[trailerBloc.state.indexMovie] ||
                              trailerBloc.state.visibleVideoTv[trailerBloc.state.indexTv]
                          ? null
                          : debouncer.slowCall(() => autoPlayTrailer(context))
                      : debouncer.slowCall(() => stopTrailer(context))
                  : debouncer.slowCall(() => stopTrailer(context));

              break;
            default:
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryText(
              title: 'TMDb originals',
              visibleIcon: true,
              hasSwitch: true,
              icon: Icon(
                Icons.video_library_rounded,
                size: 24,
                color: greyColor,
              ),
              child: BlocBuilder<TrailerBloc, TrailerState>(
                builder: (context, state) {
                  if (state is TrailerError) {
                    return SizedBox(height: 22.h);
                  }
                  return CustomSwitch(
                    firstTitle: 'Theaters',
                    secondTitle: 'TV',
                    isActive: state.isActive,
                    onSwitchMovie: () => switchTheater(context),
                    onSwitchTV: () => switchTv(context),
                  );
                },
              ),
            ),
            BlocBuilder<TrailerBloc, TrailerState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<TrailerBloc>(context);
                if (state is TrailerInitial) {
                  return SizedBox(
                    height: 240.h,
                    child: const CustomIndicator(radius: 10),
                  );
                }
                if (state is TrailerError) {
                  return SizedBox(
                    height: 240.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Container(
                    height: 240.h,
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0.h),
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      controller: bloc.theaterController,
                      itemBuilder: itemBuilderTheater,
                      itemCount: state.listMovie.length,
                      onPageChanged: (value) {
                        if (value != bloc.state.indexMovie) {
                          bloc.state.visibleVideoMovie[value]
                              ? null
                              : debouncer.slowCall(
                                  () => bloc.add(PlayTrailer(
                                    indexMovie: value,
                                    indexTv: state.indexTv,
                                    isActive: bloc.state.isActive,
                                    visibleVideoMovie: bloc.state.visibleVideoMovie,
                                    visibleVideoTv: bloc.state.visibleVideoTv,
                                  )),
                                );
                          // log('Hello 2 value $value state.indexMovie ${state.indexMovie} state.indexTv ${state.indexTv} ');

                          bloc.add(StopTrailer(
                            indexMovie: state.indexMovie,
                            indexTv: state.indexTv,
                            isActive: bloc.state.isActive,
                            visibleVideoMovie: bloc.state.visibleVideoMovie,
                            visibleVideoTv: bloc.state.visibleVideoTv,
                          ));
                        } else {
                          bloc.state.visibleVideoMovie[value]
                              ? null
                              : debouncer.slowCall(
                                  () => bloc.add(PlayTrailer(
                                    indexMovie: value,
                                    indexTv: state.indexTv,
                                    isActive: bloc.state.isActive,
                                    visibleVideoMovie: bloc.state.visibleVideoMovie,
                                    visibleVideoTv: bloc.state.visibleVideoTv,
                                  )),
                                );
                        }
                      },
                    ),
                  ),
                  secondChild: Container(
                    height: 240.h,
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0.h),
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      controller: bloc.tvController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: itemBuilderTv,
                      itemCount: state.listTv.length,
                      onPageChanged: (value) {
                        if (value != bloc.state.indexTv) {
                          bloc.state.visibleVideoTv[value]
                              ? null
                              : debouncer.slowCall(
                                  () => bloc.add(PlayTrailer(
                                    indexMovie: state.indexMovie,
                                    indexTv: value,
                                    isActive: bloc.state.isActive,
                                    visibleVideoMovie: bloc.state.visibleVideoMovie,
                                    visibleVideoTv: bloc.state.visibleVideoTv,
                                  )),
                                );
                          bloc.add(StopTrailer(
                            indexMovie: state.indexMovie,
                            indexTv: state.indexTv,
                            isActive: bloc.state.isActive,
                            visibleVideoMovie: bloc.state.visibleVideoMovie,
                            visibleVideoTv: bloc.state.visibleVideoTv,
                          ));
                        } else {
                          bloc.state.visibleVideoTv[value]
                              ? null
                              : debouncer.slowCall(
                                  () => bloc.add(PlayTrailer(
                                    indexMovie: state.indexMovie,
                                    indexTv: value,
                                    isActive: bloc.state.isActive,
                                    visibleVideoMovie: bloc.state.visibleVideoMovie,
                                    visibleVideoTv: bloc.state.visibleVideoTv,
                                  )),
                                );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget itemBuilderTheater(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listMovie[index];
    final itemTrailer = bloc.state.listTrailerMovie[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: true,
        autoPlay: bloc.state.visibleVideoMovie[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    )..setPlaybackRate(1.0);
    return QuinaryItemList(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      visibleVideo: bloc.state.visibleVideoMovie[index],
      title: item.title,
      nameOfTrailer: itemTrailer.name ?? 'Coming soon',
      imageUrl: item.backdropPath == null
          ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
          : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.add(PlayTrailer(
        indexMovie: index,
        indexTv: bloc.state.indexTv,
        isActive: bloc.state.isActive,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: true,
        autoPlay: bloc.state.visibleVideoTv[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    )..setPlaybackRate(1.0);
    return QuinaryItemList(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      visibleVideo: bloc.state.visibleVideoTv[index],
      title: item.name,
      nameOfTrailer: itemTrailer.name ?? 'Coming soon',
      imageUrl: item.backdropPath == null
          ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
          : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.add(PlayTrailer(
        indexTv: index,
        isActive: bloc.state.isActive,
        indexMovie: bloc.state.indexMovie,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  switchTheater(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: false));
    debouncer.slowCall(() => autoPlayTrailer(context));
  }

  switchTv(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: true));
    debouncer.slowCall(() => autoPlayTrailer(context));
  }

  navigateDetailPage(BuildContext context) {
    stopTrailer(context);
    Navigator.of(context)
        .push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        )
        .then((_) => debouncer.slowCall(() => autoPlayTrailer(context)));
  }

  autoPlayTrailer(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    if (bloc.tvController.hasClients || bloc.theaterController.hasClients) {
      bloc.add(PlayTrailer(
        indexMovie: bloc.state.indexMovie,
        indexTv: bloc.state.indexTv,
        isActive: bloc.state.isActive,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      ));
    }
  }

  stopTrailer(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(StopTrailer(
      isActive: bloc.state.isActive,
      indexMovie: bloc.state.indexMovie,
      indexTv: bloc.state.indexTv,
      visibleVideoMovie: bloc.state.visibleVideoMovie,
      visibleVideoTv: bloc.state.visibleVideoTv,
    ));
  }

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(FetchData(language: 'en-US', page: 1, region: ''));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movie_app/shared_ui/shared_ui.dart';
// import 'package:movie_app/ui/components/components.dart';
// import 'package:movie_app/ui/pages/details/index.dart';
// import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
// import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
// import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
// import 'package:movie_app/utils/constants/constants.dart';
// import 'package:movie_app/utils/debouncer/debouncer.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class TrailerView extends StatefulWidget {
//   const TrailerView({super.key});

//   @override
//   State<TrailerView> createState() => _TrailerViewState();
// }

// class _TrailerViewState extends State<TrailerView> {
//   // late TrailerBloc trailerBloc;
//   late YoutubePlayerController controller;
//   Debouncer debouncer = Debouncer();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TrailerBloc()
//         ..add(FetchData(
//           language: 'en-US',
//           page: 1,
//           region: '',
//         )),
//       child: BlocListener<NavigationBloc, NavigationState>(
//         listener: (context, state) {
//           final trailerBloc = BlocProvider.of<TrailerBloc>(context);
//           final exploreBloc = BlocProvider.of<ExploreBloc>(context);
//           switch (state.runtimeType) {
//             case NavigationSuccess:
//               state.indexPage == 1
//                   ? trailerBloc.state is TrailerSuccess
//                       ? exploreBloc.scrollController.position.extentBefore <= 50
//                           ? debouncer.slowCall(() => playTrailer(context))
//                           : debouncer.slowCall(() => stopTrailer(context))
//                       : debouncer.slowCall(() => stopTrailer(context))
//                   : debouncer.slowCall(() => stopTrailer(context));
//               break;
//             case NavigationScrollSuccess:
//               state.indexPage == 1
//                   ? trailerBloc.state is TrailerSuccess
//                       ? debouncer.slowCall(() => playTrailer(context))
//                       : debouncer.slowCall(() => stopTrailer(context))
//                   : debouncer.slowCall(() => stopTrailer(context));

//               break;
//             default:
//               break;
//           }
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             PrimaryText(
//               title: 'TMDb originals',
//               visibleIcon: true,
//               hasSwitch: true,
//               icon: Icon(
//                 Icons.video_library_rounded,
//                 size: 24,
//                 color: greyColor,
//               ),
//               child: BlocBuilder<TrailerBloc, TrailerState>(
//                 builder: (context, state) {
//                   if (state is TrailerError) {
//                     return SizedBox(height: 22.h);
//                   }
//                   return CustomSwitch(
//                     firstTitle: 'Theaters',
//                     secondTitle: 'TV',
//                     isActive: state.isActive,
//                     onSwitchMovie: () => switchTheater(context),
//                     onSwitchTV: () => switchTv(context),
//                   );
//                 },
//               ),
//             ),
//             BlocBuilder<TrailerBloc, TrailerState>(
//               builder: (context, state) {
//                 final bloc = BlocProvider.of<TrailerBloc>(context);
//                 if (state is TrailerInitial) {
//                   return SizedBox(
//                     height: 240.h,
//                     child: const CustomIndicator(radius: 10),
//                   );
//                 }
//                 if (state is TrailerError) {
//                   return SizedBox(
//                     height: 240.h,
//                     child: Center(
//                       child: Text(state.runtimeType.toString()),
//                     ),
//                   );
//                 }
//                 return NotificationListener<ScrollNotification>(
//                   onNotification: (notification) {
//                     if (notification is ScrollEndNotification) {
//                       debouncer.slowCall(() => playTrailer(context));
//                     } else if (notification is ScrollStartNotification) {
//                       debouncer.slowCall(() => stopTrailer(context));
//                     } else if (notification is ScrollUpdateNotification) {
//                       debouncer.slowCall(() => stopTrailer(context));
//                     }
//                     return true;
//                   },
//                   child: AnimatedCrossFade(
//                     duration: const Duration(milliseconds: 400),
//                     crossFadeState:
//                         state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//                     firstChild: SizedBox(
//                       height: 240.h,
//                       child: ListView.separated(
//                         physics: const BouncingScrollPhysics(),
//                         addRepaintBoundaries: false,
//                         addAutomaticKeepAlives: true,
//                         controller: bloc.theaterController,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         padding: EdgeInsets.fromLTRB(17.w, 15.h, 17.w, 0.h),
//                         itemBuilder: itemBuilderTheater,
//                         separatorBuilder: separatorBuilder,
//                         itemCount: state.listMovie.length,
//                       ),
//                     ),
//                     secondChild: SizedBox(
//                       height: 240.h,
//                       child: ListView.separated(
//                         physics: const BouncingScrollPhysics(),
//                         addRepaintBoundaries: false,
//                         addAutomaticKeepAlives: true,
//                         controller: bloc.tvController,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         padding: EdgeInsets.fromLTRB(17.w, 15.h, 17.w, 0.h),
//                         itemBuilder: itemBuilderTv,
//                         separatorBuilder: separatorBuilder,
//                         itemCount: state.listTv.length,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   Widget itemBuilderTheater(BuildContext context, int index) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     final item = bloc.state.listMovie[index];
//     final itemTrailer = bloc.state.listTrailerMovie[index];
//     controller = YoutubePlayerController(
//       initialVideoId: itemTrailer.key ?? '',
//       flags: const YoutubePlayerFlags(
//         hideControls: true,
//         autoPlay: true,
//         mute: false,
//         disableDragSeek: true,
//         enableCaption: false,
//         useHybridComposition: true,
//         forceHD: false,
//       ),
//     )..setPlaybackRate(1.0);
//     return QuinaryItemList(
//       videoId: itemTrailer.key ?? '',
//       youtubeKey: ObjectKey(controller),
//       controller: controller,
//       visibleVideo: bloc.state.visibleVideoMovie[index],
//       title: item.title,
//       nameOfTrailer: itemTrailer.name ?? 'Coming soon',
//       imageUrl: item.backdropPath == null
//           ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
//           : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
//       onEnded: (metdaData) => stopTrailer(context),
//       onTap: () => navigateDetailPage(context),
//       onLongPress: () => bloc.add(PlayTrailer(
//         indexMovie: index,
//         isActive: bloc.state.isActive,
//         visibleVideoMovie: bloc.state.visibleVideoMovie,
//         visibleVideoTv: bloc.state.visibleVideoTv,
//       )),
//     );
//   }

//   Widget itemBuilderTv(BuildContext context, int index) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     final item = bloc.state.listTv[index];
//     final itemTrailer = bloc.state.listTrailerTv[index];
//     controller = YoutubePlayerController(
//       initialVideoId: itemTrailer.key ?? '',
//       flags: const YoutubePlayerFlags(
//         hideControls: true,
//         autoPlay: true,
//         mute: false,
//         disableDragSeek: true,
//         enableCaption: false,
//         useHybridComposition: true,
//         forceHD: false,
//       ),
//     )..setPlaybackRate(1.0);
//     return QuinaryItemList(
//       videoId: itemTrailer.key ?? '',
//       youtubeKey: ObjectKey(controller),
//       controller: controller,
//       visibleVideo: bloc.state.visibleVideoTv[index],
//       title: item.name,
//       nameOfTrailer: itemTrailer.name ?? 'Coming soon',
//       imageUrl: item.backdropPath == null
//           ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
//           : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
//       onEnded: (metdaData) => stopTrailer(context),
//       onTap: () => navigateDetailPage(context),
//       onLongPress: () => bloc.add(PlayTrailer(
//         indexTv: index,
//         isActive: bloc.state.isActive,
//         visibleVideoMovie: bloc.state.visibleVideoMovie,
//         visibleVideoTv: bloc.state.visibleVideoTv,
//       )),
//     );
//   }

//   Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 20.w);

//   switchTheater(BuildContext context) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     bloc.add(SwitchType(isActive: false));
//     debouncer.slowCall(() => playTrailer(context));
//   }

//   switchTv(BuildContext context) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     bloc.add(SwitchType(isActive: true));
//     debouncer.slowCall(() => playTrailer(context));
//   }

//   navigateDetailPage(BuildContext context) {
//     stopTrailer(context);
//     Navigator.of(context).push(
//       CustomPageRoute(
//         page: const DetailsPage(),
//         begin: const Offset(1, 0),
//       ),
//     );
//   }

//   playTrailer(BuildContext context) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     if (bloc.state.isActive) {
//       if (bloc.tvController.hasClients) {
//         double currentPosition = bloc.tvController.position.pixels;
//         int currentIndex = (currentPosition / 335.w).round();
//         bloc.state.visibleVideoTv[currentIndex]
//             ? null
//             : bloc.add(PlayTrailer(
//                 indexTv: currentIndex,
//                 isActive: bloc.state.isActive,
//                 visibleVideoMovie: bloc.state.visibleVideoMovie,
//                 visibleVideoTv: bloc.state.visibleVideoTv,
//               ));
//       }
//     } else {
//       if (bloc.theaterController.hasClients) {
//         double currentPosition = bloc.theaterController.position.pixels;
//         int currentIndex = (currentPosition / 335.w).round();
//         bloc.state.visibleVideoMovie[currentIndex]
//             ? null
//             : bloc.add(PlayTrailer(
//                 indexMovie: currentIndex,
//                 isActive: bloc.state.isActive,
//                 visibleVideoMovie: bloc.state.visibleVideoMovie,
//                 visibleVideoTv: bloc.state.visibleVideoTv,
//               ));
//       }
//     }
//   }

//   stopTrailer(BuildContext context) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     bloc.add(StopTrailer());
//   }

//   reloadList(BuildContext context) {
//     final bloc = BlocProvider.of<TrailerBloc>(context);
//     bloc.add(FetchData(language: 'en-US', page: 1, region: ''));
//   }
// }
