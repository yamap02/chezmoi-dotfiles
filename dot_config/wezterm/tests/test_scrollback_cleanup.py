"""Exercise the shell payload used by WezTerm without starting the GUI."""
from pathlib import Path
import os
import re
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ScrollbackCleanup(unittest.TestCase):
    def test_editor_reads_file_before_cleanup_and_preserves_exit_status(self):
        source = (ROOT / 'on.lua').read_text()
        script = re.search(r'"-c", \[\[(.*?)\]\]', source, re.S).group(1)
        for code in (0, 7):
            with self.subTest(exit_status=code), tempfile.TemporaryDirectory() as tmp:
                directory = Path(tmp)
                scrollback = directory / "scroll back ' 日本語.txt"
                scrollback.write_text('terminal output\n')
                editor = directory / 'nvim'
                editor.write_text('#!/bin/sh\n[ "$1" = -- ] || exit 90\n'
                                  '/bin/cat "$2" || exit 91\n'
                                  f'exit {code}\n')
                editor.chmod(0o700)
                env = dict(os.environ, PATH=f'{directory}:/usr/bin:/bin')
                result = subprocess.run(
                    ['/bin/zsh', '-df', '-c', script, 'wezterm-scrollback', str(scrollback)],
                    env=env, text=True, capture_output=True,
                )
                self.assertEqual(result.returncode, code, result.stderr)
                self.assertEqual(result.stdout, 'terminal output\n')
                self.assertFalse(scrollback.exists())


if __name__ == '__main__':
    unittest.main()
