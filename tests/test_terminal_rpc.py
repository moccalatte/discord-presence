import os
import json
import tempfile
import unittest
from pathlib import Path

from terminal_rpc import sanitize_path, load_config, read_shell_state, format_status, scan_running_terminals, ensure_single_instance, get_foreground_window_title

class TestTerminalRPC(unittest.TestCase):

    def test_sanitize_path_folder_mode(self):
        path = os.path.join("C:", "Users", "Dev", "Projects", "my-awesome-app")
        self.assertEqual(sanitize_path(path, privacy_mode="folder"), "my-awesome-app")

    def test_sanitize_path_hidden_mode(self):
        path = os.path.join("C:", "Users", "Dev", "SecretFolder")
        self.assertEqual(sanitize_path(path, privacy_mode="hidden"), "Workspace")

    def test_sanitize_path_full_mode(self):
        home = str(Path.home())
        sub_path = os.path.join(home, "Projects", "test")
        sanitized = sanitize_path(sub_path, privacy_mode="full")
        self.assertTrue(sanitized.startswith("~"))
        self.assertIn("/Projects/test", sanitized)

    def test_load_config_default_and_custom(self):
        config = load_config("non_existent_config.json")
        self.assertIn("client_id", config)
        self.assertEqual(config["privacy_mode"], "folder")
        self.assertEqual(config["assets"]["large_text"], "Console")

        with tempfile.NamedTemporaryFile("w+", delete=False, suffix=".json") as tf:
            json.dump({"privacy_mode": "full", "client_id": "99999"}, tf)
            tf_path = tf.name

        try:
            custom_cfg = load_config(tf_path)
            self.assertEqual(custom_cfg["privacy_mode"], "full")
            self.assertEqual(custom_cfg["client_id"], "99999")
        finally:
            if os.path.exists(tf_path):
                os.remove(tf_path)

    def test_read_shell_state(self):
        with tempfile.NamedTemporaryFile("w+", delete=False, suffix=".json") as tf:
            json.dump({"shell": "PowerShell", "cwd": "C:/Projects/demo", "user": "morph@potion:"}, tf)
            tf_path = tf.name

        try:
            state = read_shell_state(tf_path)
            self.assertIsNotNone(state)
            self.assertEqual(state["shell"], "PowerShell")
            self.assertEqual(state["cwd"], "C:/Projects/demo")
            self.assertEqual(state["user"], "morph@potion:")
        finally:
            if os.path.exists(tf_path):
                os.remove(tf_path)

    def test_format_status(self):
        config = {
            "privacy_mode": "folder",
            "show_tabs": True,
            "emojis": {
                "powershell": "⚡",
                "folder": "📁",
                "idle": "💤"
            },
            "assets": {
                "powershell_small_image": "powershell_icon",
                "powershell_small_text": "PowerShell"
            }
        }

        active_shells = ["powershell.exe", "cmd.exe", "windowsterminal.exe"]
        state_data = {"shell": "CMD", "cwd": "C:/Users/takea/Projects/my-backend", "user": ""}
        active_status = format_status(active_shells, state_data, config)

        self.assertIn("3 tabs", active_status["details"])
        self.assertIn("📁 my-backend", active_status["state"])

    def test_single_instance_lock(self):
        lock_status = ensure_single_instance()
        self.assertTrue(lock_status)

    def test_foreground_window_title_function(self):
        # Function returns string or None depending on OS and focus
        res = get_foreground_window_title()
        self.assertTrue(res is None or isinstance(res, str))

if __name__ == "__main__":
    unittest.main()
