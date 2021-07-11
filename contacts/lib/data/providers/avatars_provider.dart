import '../models/avatar.dart';

class AvatarsProvider {
  List<Avatar> _avatars = List<Avatar>.generate(
    70,
    (index) => Avatar(
      id: index,
      avatar: 'assets/icons/avatars/${index + 1}.png',
    ),
  );

  List<Avatar> get avatars => [..._avatars];
}
