import tomllib
import unittest
from pathlib import Path


YAZI_DIR = Path("/Users/user/.config/yazi")
KEYMAP_PATH = YAZI_DIR / "keymap.toml"
README_PATH = YAZI_DIR / "README.md"
SMART_ENTER_PATH = YAZI_DIR / "plugins" / "smart-enter.yazi" / "main.lua"


def normalize_key(on):
    if isinstance(on, list):
        return tuple(on)
    return (on,)


def load_keymap():
    with KEYMAP_PATH.open("rb") as fh:
        data = tomllib.load(fh)
    entries = data["mgr"]["prepend_keymap"]
    return {normalize_key(entry["on"]): entry["run"] for entry in entries}


class YaziKeymapMigrationTest(unittest.TestCase):
    def test_expected_files_exist(self):
        self.assertTrue(KEYMAP_PATH.exists(), "keymap.toml が未作成")
        self.assertTrue(README_PATH.exists(), "README.md が未作成")
        self.assertTrue(SMART_ENTER_PATH.exists(), "smart-enter plugin が未作成")

    def test_core_navigation_keymap_matches_ranger(self):
        keymap = load_keymap()
        self.assertEqual(keymap[("h",)], "leave")
        self.assertEqual(keymap[("j",)], "arrow 1")
        self.assertEqual(keymap[("k",)], "arrow -1")
        self.assertEqual(keymap[("l",)], "plugin smart-enter")
        self.assertEqual(keymap[("<Enter>",)], "plugin smart-enter")
        self.assertEqual(keymap[("H",)], "back")
        self.assertEqual(keymap[("L",)], "forward")
        self.assertEqual(keymap[("J",)], "arrow 50%")
        self.assertEqual(keymap[("K",)], "arrow -50%")

    def test_search_selection_and_clipboard_keymap_matches_ranger(self):
        keymap = load_keymap()
        self.assertEqual(keymap[("/",)], "find --smart")
        self.assertEqual(keymap[("n",)], "find_arrow")
        self.assertEqual(keymap[("N",)], "find_arrow --previous")
        self.assertEqual(keymap[("f",)], "filter --smart")
        self.assertEqual(keymap[("<Space>",)], "toggle")
        self.assertEqual(keymap[("v",)], "toggle_all")
        self.assertEqual(keymap[("u", "v")], "toggle_all --state=off")
        self.assertEqual(keymap[("V",)], "visual_mode")
        self.assertEqual(keymap[("u", "V")], "visual_mode --unset")
        self.assertEqual(keymap[("y", "p")], "copy path --hovered --separator=unix")
        self.assertEqual(keymap[("y", "d")], "copy dirname --hovered --separator=unix")
        self.assertEqual(keymap[("y", "n")], "copy filename --hovered")
        self.assertEqual(keymap[("y", ".")], "copy name_without_ext --hovered")

    def test_file_ops_tabs_sort_and_toggles_match_ranger(self):
        keymap = load_keymap()
        self.assertEqual(keymap[("d", "d")], "yank --cut")
        self.assertEqual(keymap[("y", "y")], "yank")
        self.assertEqual(keymap[("u", "d")], "unyank")
        self.assertEqual(keymap[("u", "y")], "unyank")
        self.assertEqual(keymap[("p", "p")], "paste")
        self.assertEqual(keymap[("d", "D")], "remove")
        self.assertEqual(keymap[("c", "w")], "rename")
        self.assertEqual(keymap[("g", "n")], "tab_create ~")
        self.assertEqual(keymap[("g", "c")], "close")
        self.assertEqual(keymap[("<Tab>",)], "tab_switch 1 --relative")
        self.assertEqual(keymap[("<BackTab>",)], "tab_switch -1 --relative")
        self.assertEqual(keymap[("o", "n")], "sort natural --reverse=no")
        self.assertEqual(keymap[("o", "m")], "sort mtime --reverse=no")
        self.assertEqual(keymap[("o", "s")], "sort size --reverse=no")
        self.assertEqual(keymap[("o", "r")], "sort --reverse")
        self.assertEqual(keymap[("z", "h")], "hidden toggle")
        self.assertEqual(keymap[("<C-h>",)], "hidden toggle")

    def test_directory_jumps_match_ranger(self):
        keymap = load_keymap()
        expected = {
            ("g", "h"): "cd ~",
            ("g", "e"): "cd /etc",
            ("g", "u"): "cd /usr",
            ("g", "d"): "cd /dev",
            ("g", "l"): "cd .",
            ("g", "o"): "cd /opt",
            ("g", "v"): "cd /var",
            ("g", "m"): "cd /media",
            ("g", "M"): "cd /mnt",
            ("g", "s"): "cd /srv",
            ("g", "r"): "cd /",
            ("g", "/"): "cd /",
        }
        for key, run in expected.items():
            self.assertEqual(keymap[key], run)

    def test_readme_mentions_ranger_migration_scope(self):
        text = README_PATH.read_text(encoding="utf-8")
        self.assertIn("ranger", text)
        self.assertIn("smart-enter", text)
        self.assertIn("keymap.toml", text)

    def test_readme_documents_default_backed_settings(self):
        text = README_PATH.read_text(encoding="utf-8")
        self.assertIn("既定値を明文化", text)
        self.assertIn("yazi-rs.github.io/docs/configuration/overview", text)
        self.assertIn("shipped tag", text)
        self.assertIn("font size", text)
        self.assertIn("ターミナルエミュレータ側", text)
        self.assertIn("ratio = [1, 4, 3]", text)
        self.assertIn('sort_by = "alphabetical"', text)
        self.assertIn("show_hidden = false", text)
        self.assertIn("tab_size = 2", text)
        self.assertIn('`prepend_keymap`', text)
        self.assertIn('`keymap-default.toml`', text)

    def test_yazi_toml_documents_which_defaults_are_intentional(self):
        text = (YAZI_DIR / "yazi.toml").read_text(encoding="utf-8")
        self.assertIn("https://yazi-rs.github.io/docs/configuration/overview/", text)
        self.assertIn("https://github.com/sxyazi/yazi/tree/shipped/yazi-config/preset", text)
        self.assertIn("font size", text)
        self.assertIn("ターミナルエミュレータ側", text)
        self.assertIn("theme.toml", text)
        self.assertIn("ratio = [1, 4, 3]", text)
        self.assertIn('sort_by = "alphabetical"', text)
        self.assertIn("show_hidden = false", text)
        self.assertIn("tab_size = 2", text)
        self.assertIn("既定のまま使う", text)


if __name__ == "__main__":
    unittest.main()
