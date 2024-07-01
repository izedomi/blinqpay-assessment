import 'package:blinqpay/app/repository/post_repository.dart';
import 'package:blinqpay/app/repository/user_repository.dart';
import 'package:blinqpay/app/utils/app_init_util.dart';
import 'package:blinqpay/view_models/post_view_model.dart';
import 'package:blinqpay/view_models/shared/tabs_view_model.dart';
import 'package:blinqpay/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => PostViewModel(getIt<PostRepository>())),
  ChangeNotifierProvider(create: (_) => UserViewModel(getIt<UserRepository>())),
  ChangeNotifierProvider(create: (_) => TabsViewModel()),
];
