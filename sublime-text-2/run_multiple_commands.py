import sublime
import sublime_plugin


class RunMultipleCommandsCommand(sublime_plugin.TextCommand):

    """Runs multiple commands in a given order.

    Takes a list of commands (same as those you'd provide to a key binding)
    with an optional context and runs each command in order.

    Valid contexts are 'text', 'window', and 'app' for running a TextCommand,
    WindowCommands, or ApplicationCommand respectively.

    """

    def run(self, edit, commands=None):
        if commands is None:
            return
        for command in commands:
            self._exec_command(command)

    def _exec_command(self, command):
        try:
            command_name = command['command']
        except KeyError:
            raise ValueError('No command name provided.')

        args = command.get('args')
        context = self._get_context(command)

        if args is None:
            context.run_command(command_name)
        else:
            context.run_command(command_name, args)

    def _get_context(self, command):
        context_name = command.get('context')
        if not context_name or context_name == 'text':
            context = self.view
        elif context_name == 'window':
            context = context.window()
        elif context_name == 'app':
            context = sublime
        else:
            error = 'Invalid command context "{0}".'.format(context_name)
            raise ValueError(error)
        return context
