import os
import json
import tempfile
import unittest
from pathlib import Path

from terminal_rpc import sanitize_path, load_config, read_shell_state, format_status, scan_running_terminals

class TestTerminalRPC(unittest.TestCase):

    def test_sanitize_path_folder_mode(self):
        # Folder mode returns last directory name
        path = os.path.join("C:", "Users", "Dev", "Projects", "my-awesome-app")
        self.assertEqual(sanitize_path(path, privacy_mode="folder"), "my-awesome-app")

    def test_sanitize_path_hidden_mode(self):
        # Hidden mode returns static placeholder
        path = os.path.join("C:", "Users", "Dev", "SecretFolder")
        self.assertEqual(sanitize_path(path, privacy_mode="hidden"), "Workspace")

    def test_sanitize_path_full_mode(self):
        # Full mode replaces home path with ~
        home = str(Path.home())
        sub_path = os.path.join(home, "Projects", "test")
        sanitized = sanitize_path(sub_path, privacy_mode="full")
        self.assertTrue(sanitized.startswith("~"))
        self.assertIn("/Projects/test", sanitized)

    def test_load_config_default_and_custom(self):
        # Default config load
        config = load_config("non_existent_config.json")
        self.assertIn("client_id", config)
        self.assertEqual(config["privacy_mode"], "folder")
        self.assertEqual(config["assets"]["large_text"], "Console")

        # Custom config load
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

        # Idle case
        idle_status = format_status([], None, config)
        self.assertIn("💤", idle_status["details"])

        # Active case with user context and multiple tabs
        active_shells = ["powershell.exe", "cmd.exe", "windowsterminal.exe"]
        state_data = {"shell": "PowerShell", "cwd": "/home/user/project/my-api", "user": "morph@potion:"}
        active_status = format_status(active_shells, state_data, config)

        self.assertIn("⚡ PowerShell", active_status["details"])
        self.assertIn("3 tabs", active_status["details"])
        self.assertIn("📁 morph@potion: my-api", active_status["state"])

    def test_scan_running_terminals(self):
        # scan_running_terminals returns a list of detected shell processes
        shells = scan_running_terminals()
        self.assertIsInstance(shells, list)

if __name__ == "__main__":
    unittest.main()
