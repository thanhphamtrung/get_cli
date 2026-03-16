import 'package:dex_cli/common/utils/logger/log_utils.dart';
import 'package:dex_cli/exception_handler/exception_handler.dart';
import 'package:dex_cli/functions/version/version_update.dart';
import 'package:dex_cli/dex_cli.dart';

Future<void> main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();
  final command = DexCli(arguments).findCommand();

  if (arguments.contains('--debug')) {
    if (command.validate()) {
      await command.execute().then((value) => checkForUpdate());
    }
  } else {
    try {
      if (command.validate()) {
        await command.execute().then((value) => checkForUpdate());
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
  }
  time.stop();
  LogService.info('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}
