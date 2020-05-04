"""
IPython configuration with custom prompt using gruvbox colors.
- https://github.com/reillysiemens/ipython-style-gruvbox

Thanks to @petobens for their excellent dotfiles.
- https://github.com/petobens/dotfiles
"""
from typing import List, Optional, Tuple

import IPython.terminal.prompts as prompts
from prompt_toolkit.application import get_app
from prompt_toolkit.key_binding.vi_state import InputMode
from pygments.token import _TokenType, Token

from gruvbox import Color, GruvboxStyle

config = get_config()  # type: ignore # noqa: E0602


class Prompt(prompts.Prompts):
    """Custom IPython prompt."""

    _before: str = "❰"
    _after: str = "❱ ⬢ "
    _continuation: str = "… "

    def in_prompt_tokens(self) -> List[Tuple[_TokenType, str]]:
        """Return in prompt."""
        if get_app().vi_state.input_mode == InputMode.INSERT:
            prompt_token = prompts.Token.InsertPrompt
            num_token = prompts.Token.InsertPromptNum
        else:
            prompt_token = prompts.Token.NavPrompt
            num_token = prompts.Token.NavPromptNum

        return [
            (prompt_token, self._before),
            (num_token, str(self.shell.execution_count)),
            (prompt_token, self._after),
        ]

    def continuation_prompt_tokens(
        self, width: Optional[int] = None
    ) -> List[Tuple[_TokenType, str]]:
        """Return continuation prompt."""
        if width is None:
            width = self._width()

        if get_app().vi_state.input_mode == InputMode.INSERT:
            token = prompts.Token.InsertPrompt
        else:
            token = prompts.Token.NavPrompt

        return [(token, " " * (width - 2) + self._continuation)]

    def out_prompt_tokens(self) -> List[Tuple[_TokenType, str]]:
        """Return out prompt."""
        return []


config.TerminalIPythonApp.display_banner = False
config.TerminalInteractiveShell.confirm_exit = False
config.TerminalInteractiveShell.editing_mode = "vi"
config.TerminalInteractiveShell.true_color = True
config.TerminalInteractiveShell.prompts_class = Prompt
config.TerminalInteractiveShell.highlighting_style = GruvboxStyle
config.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.InsertPrompt: Color.neutral_blue,
    Token.NavPrompt: Color.neutral_purple,
    Token.InsertPromptNum: f"{Color.neutral_purple} bold",
    Token.NavPromptNum: f"{Color.neutral_blue} bold",
}
