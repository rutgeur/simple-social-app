import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/repository/api_repository.dart';

part 'post_screen_state.dart';

class PostScreenCubit extends Cubit<PostScreenState> {
  final APIRepository _apiRepository;

  PostScreenCubit(this._apiRepository) : super(PostScreenInitial());

  Future<void> retrieveData(Post post) async {
    emit(Loading());
    try {
      final comments = await _apiRepository.getCommentsForPost(post.id.toString());
      emit(LoadedData(comments));
    } catch (APIError) {
      emit(Error());
    }
  }
}
