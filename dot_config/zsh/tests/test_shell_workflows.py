"""Run with python3 test_shell_workflows.py; no installed plugins needed."""
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


def zsh(script, *args, interactive=False):
    return subprocess.run(
        ['/bin/zsh', '-df' + ('i' if interactive else ''), '-c', script,
         'test', str(ROOT), *map(str, args)],
        text=True, capture_output=True,
    )


class ShellWorkflows(unittest.TestCase):
    def check(self, result):
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_rbenv_initialized_once(self):
        for interactive in (False, True):
            with self.subTest(interactive=interactive):
                result = zsh('''
                    path=(/usr/bin /bin)
                    init_count=0
                    rbenv() { print '(( init_count += 1 ))'; }
                    source "$1/env.sh"
                    if [[ -o interactive ]]; then
                        source "$1/external_tool_init.zsh"
                    fi
                    [[ $init_count == 1 ]]
                ''', interactive=interactive)
                self.check(result)

    def test_branch_selection_and_cancel(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = zsh('''
                source "$1/function.zsh"
                cd "$2"
                git init -q -b main || exit
                git -c user.name=Test -c user.email=test@example.invalid \\
                    -c core.hooksPath=/dev/null commit -qm initial --allow-empty || exit
                git branch feature/test || exit
                fzf() {
                    local line
                    while IFS= read -r line; do
                        [[ ${line%%$'\\t'*} != "$selected_branch" ]] || print -r -- "$line"
                    done
                }
                selected_branch=main
                fbr || exit
                [[ $(git branch --show-current) == main ]] || exit 1
                selected_branch=feature/test
                fbr || exit
                [[ $(git branch --show-current) == feature/test ]] || exit 1
                fzf() { command cat >/dev/null; return 130; }
                fbr
                [[ $? == 130 && $(git branch --show-current) == feature/test ]]
            ''', tmp)
            self.check(result)

    def test_repository_jump_quotes_and_cancel(self):
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / 'repo root' / 'a $(false); b'
            target.mkdir(parents=True)
            result = zsh('''
                source "$1/bindkey.zsh"
                repo_root="$2/repo root"
                ghq() {
                    case $1 in
                      list) print -r -- 'a $(false); b';;
                      root) print -r -- "$repo_root";;
                    esac
                }
                fzf() { command cat; }
                zle() { [[ "$1" != accept-line ]] || eval "$BUFFER"; }
                ghq-fzf || exit
                [[ $PWD == "$repo_root/a \$(false); b" ]] || exit 1
                BUFFER=unchanged
                fzf() { command cat >/dev/null; return 130; }
                ghq-fzf
                [[ $? == 130 && $BUFFER == unchanged ]]
            ''', tmp)
            self.check(result)

    def test_history_bindings_after_plugin_load(self):
        result = zsh('''
            source "$1/bindkey.zsh"
            history-substring-search-up() { :; }
            history-substring-search-down() { :; }
            zle -N history-substring-search-up
            zle -N history-substring-search-down
            _bind_history_substring_search
            [[ $(bindkey -M emacs '^N') == *history-substring-search-down ]] || exit 1
            [[ $(bindkey -M emacs '^P') == *history-beginning-search-backward ]]
        ''')
        self.check(result)


if __name__ == '__main__':
    unittest.main()
