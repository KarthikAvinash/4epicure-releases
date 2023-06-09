import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/playlist_model.dart';
import '../services/api_services.dart';
import '../utilities/fetch_result.dart';

class PlaylistProvider extends StateNotifier<AsyncValue<Playlist>> {
  PlaylistProvider(PlayListType playListType) : super(const AsyncLoading()) {
    _init(playListType);
  }

  Playlist? get playlist {
    return state.value;
  }

  Future<void> loadMoreVideos({
    required FetchType fetchType,
    String query = "",
  }) async {
    Playlist currentPlaylist = playlist ?? Playlist();

    state = const AsyncLoading();

    FetchResult moreVideos;

    try {
      moreVideos = await APIServices.instance.fetchMoreVideos(
        fetchType: fetchType,
        nextPageToken: currentPlaylist.nextPageToken,
        query: query,
      );
    } catch (e) {
      state = AsyncError("Error loading more videos", StackTrace.current);
      return;
    }

    currentPlaylist.addVideos(moreVideos.videos, sort: false);
    currentPlaylist.nextPageToken = moreVideos.nextPageToken;
    state = AsyncData(currentPlaylist);
  }

  Future<void> searchVideos(String searchText) async {
    state = const AsyncLoading();
    FetchResult result;

    try {
      result = await APIServices.instance.fetchQuery(searchText);
      state = AsyncData(
        Playlist(
          videos: result.videos,
          totalYoutubeVideos: result.videoCount,
          nextPageToken: result.nextPageToken,
        ),
      );
    } catch (e) {
      state = AsyncError("Error loading more videos", StackTrace.current);
    }
  }

  Future<void> fetchRelatedVideos(
      {required String videoId, required String nextPageToken}) async {
    state = const AsyncLoading();

    FetchResult result;

    try {
      result = await APIServices.instance.fetchQuery(videoId,
          nextPageToken: nextPageToken, isRelatedVideos: true);
      state = AsyncData(
        Playlist(
          videos: result.videos,
          totalYoutubeVideos: result.videoCount,
          nextPageToken: result.nextPageToken,
        ),
      );
    } catch (e) {
      state = AsyncError("Error loading more videos", StackTrace.current);
    }
  }

  void _init(PlayListType playListType) async {
    switch (playListType) {
      case PlayListType.channel:
        state = const AsyncLoading();
        break;
      case PlayListType.related:
        state = const AsyncLoading();
        break;
      case PlayListType.trending:
        try {
          Playlist trending = await APIServices.instance.fetchTrending();
          state = AsyncData(trending);
        } catch (e) {
          state = AsyncError("Error loading more videos", StackTrace.current);
        }
        break;
    }
  }
}
