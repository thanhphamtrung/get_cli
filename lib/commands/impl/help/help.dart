import 'package:ansicolor/ansicolor.dart';

import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../functions/version/print_dex_cli.dart';
import '../../commands_list.dart';
import '../../interface/command.dart';

/// ANSI pen styles for help output formatting
final _penCommand = AnsiPen()..cyan(bold: true);
final _penSubcommand = AnsiPen()..green(bold: true);
final _penHint = AnsiPen()..gray(level: 0.7);
final _penAlias = AnsiPen()..magenta();
final _penSection = AnsiPen()..yellow(bold: true);
final _penDim = AnsiPen()..gray(level: 0.4);

class HelpCommand extends Command {
  @override
  String get commandName => 'help';

  @override
  String? get hint => Translation(LocaleKeys.hint_help).tr;

  @override
  Future<void> execute() async {
    printDexCli();

    // Separate parent commands (with children) from standalone commands
    final parentCommands = <Command>[];
    final standaloneCommands = <Command>[];
    final flagCommands = <Command>[];

    for (final cmd in commands) {
      if (cmd.commandName.startsWith('-')) {
        flagCommands.add(cmd);
      } else if (cmd.childrens.isNotEmpty) {
        parentCommands.add(cmd);
      } else {
        standaloneCommands.add(cmd);
      }
    }

    parentCommands.sort((a, b) => a.commandName.compareTo(b.commandName));
    standaloneCommands.sort((a, b) => a.commandName.compareTo(b.commandName));

    final buffer = StringBuffer();

    // --- Scaffold section: parent commands with subcommands ---
    if (parentCommands.isNotEmpty) {
      buffer.writeln('  ${_penSection('Scaffold')}');
      buffer.writeln();
      for (final parent in parentCommands) {
        final aliasStr = _formatAlias(parent.alias);
        buffer.writeln(
          '    ${_penCommand(parent.commandName)}$aliasStr',
        );
        final sorted = List<Command>.from(parent.childrens)
          ..sort((a, b) => a.commandName.compareTo(b.commandName));
        for (final child in sorted) {
          final childAlias = _formatAlias(child.alias);
          final hint = child.hint ?? '';
          buffer.writeln(
            '      ${_penSubcommand(child.commandName.padRight(14))}$childAlias${_penHint(hint)}',
          );
        }
        buffer.writeln();
      }
    }

    // --- Workflow section: standalone commands ---
    if (standaloneCommands.isNotEmpty) {
      buffer.writeln('  ${_penSection('Workflow')}');
      buffer.writeln();
      for (final cmd in standaloneCommands) {
        if (cmd.commandName == 'help') continue;
        final aliasStr = _formatAlias(cmd.alias);
        final hint = cmd.hint ?? '';
        buffer.writeln(
          '    ${_penCommand(cmd.commandName.padRight(16))}$aliasStr${_penHint(hint)}',
        );
      }
      buffer.writeln();
    }

    // --- Flags section ---
    if (flagCommands.isNotEmpty) {
      buffer.writeln('  ${_penSection('Options')}');
      buffer.writeln();
      for (final cmd in flagCommands) {
        final aliasStr = _formatAlias(cmd.alias);
        final hint = cmd.hint ?? '';
        buffer.writeln(
          '    ${_penCommand(cmd.commandName.padRight(16))}$aliasStr${_penHint(hint)}',
        );
      }
      buffer.writeln();
    }

    // --- Help hint ---
    buffer.writeln(
      '  ${_penDim('Run')} ${_penCommand('dex help')} ${_penDim('for this message')}',
    );

    // Print without LogService wrapping (no extra yellow color)
    // ignore: avoid_print
    print(buffer.toString());
  }

  /// Format alias list like " (-c) " or empty string
  String _formatAlias(List<String> aliases) {
    if (aliases.isEmpty) return '';
    return ' ${_penAlias('(${aliases.join(', ')})')} ';
  }

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;
}
