# 🖥️ Terminal Discord Rich Presence

Aplikasi Discord Rich Presence yang ringan, kreatif, interaktif, dan menjaga privasi untuk **Windows Terminal**, **PowerShell**, dan **Command Prompt (CMD)**!

---

## ✨ Fitur Utama

- ⚡ **Ringan & Cepat**: Menggunakan IPC socket/pipe bawaan tanpa pustaka berat.
- 🎨 **Interaktif & Aesthetic**: Menampilkan status shell aktif (PowerShell ⚡, CMD 💻, WSL 🐧, Terminal 🖥️), jumlah tab aktif (difilter akurat), context nama user/SSH (misal `morph@potion:`), dan direktori kerja saat ini.
- 🔒 **Single-Instance Mutex**: Memastikan hanya ada 1 proses `pythonw.exe` yang berjalan di background tanpa proses ganda (duplicate PID).
- 🏷️ **Hover Title Custom**: Saat icon presence di-hover mouse di Discord, secara default akan menampilkan nama **Console**.
- 🔒 **Menjaga Privasi**:
  - `folder`: Hanya menampilkan nama folder/proyek aktif (contoh: `📁 my-project`).
  - `full`: Menampilkan direktori lengkap dengan penyamaan path rumah (`~`).
  - `hidden`: Hanya menampilkan `📁 Workspace`.
- 🚀 **Pure Batch AutoRun**: Skrip hook CMD murni tanpa subprocess PowerShell tambahan untuk performa instan tanpa lag.

---

## 📥 Cara Download & Instalasi

Pilih salah satu cara di bawah ini yang paling mudah untukmu:

### Opsi A: Menggunakan Git Clone (Direkomendasikan)
Buka Terminal / PowerShell / CMD lalu jalankan:
```bash
git clone https://github.com/moccalatte/discord-presence.git
cd discord-presence
```

---

### Opsi B: Instalasi Cepat via PowerShell (`irm` One-Liner)
Buka PowerShell dan jalankan perintah berikut untuk mengunduh project secara langsung:
```powershell
irm https://raw.githubusercontent.com/moccalatte/discord-presence/main/install.ps1 | iex
```

---

## 🛠️ Panduan Langkah-demi-Langkah (Step-by-Step)

### 1. Persiapan Discord Developer Portal
1. Buka [Discord Developer Portal](https://discord.com/developers/applications).
2. Klik **New Application**, beri nama misal `Terminal` atau `PowerShell`.
3. Salin **APPLICATION ID** (Client ID) milikmu.
4. (Opsional) Di menu **Rich Presence > Art Assets**, unggah gambar berikut agar icon muncul di Discord:
   - Asset Utama: `terminal_main`
   - Asset Small Shell: `powershell_icon`, `cmd_icon`, `wsl_icon`, `terminal_icon`

---

### 2. Konfigurasi Client ID & Mode Privasi
Buka file `config.json` di folder utama project ini, ganti `client_id` dengan Application ID milikmu:

```json
{
  "client_id": "MASUKKAN_CLIENT_ID_DISCORD_KAMU_DISINI",
  "privacy_mode": "folder",
  "update_interval": 3,
  "show_tabs": true,
  "show_elapsed": true,
  "emojis": {
    "powershell": "⚡",
    "cmd": "💻",
    "wsl": "🐧",
    "terminal": "🖥️",
    "folder": "📁",
    "idle": "💤"
  },
  "assets": {
    "large_image": "terminal_main",
    "large_text": "Console"
  }
}
```

---

### 3. Setup Otomatis Shell Profile (Otomatis Sync Folder Aktif)

#### 🔹 Untuk Command Prompt (CMD)
Cukup klik dua kali pada file `setup_cmd_autorun.bat`. Skrip ini mendaftarkan hook batch murni (`scripts/cmd_prompt.cmd`) di Registry AutoRun sehingga setiap kali kamu membuka CMD atau berpindah folder (`cd`), direktori aktif langsung otomatis diperbarui di Discord secara instan!

#### 🔹 Untuk PowerShell
Cukup klik dua kali pada file `setup_powershell_profile.bat`. Skrip ini otomatis menambahkan hook sync ke file `$PROFILE` PowerShell milikmu.

---

### 4. Menjalankan, Mematikan, & Autostart saat Windows Startup

#### 🏃 Menjalankan Manual
Jalankan file Python utama:
```bash
python terminal_rpc.py
```
Atau tanpa jendela konsol (background mode):
```cmd
pythonw terminal_rpc.py
```

#### 🛑 Cara Mematikan Background Process (`pythonw.exe`)
Gunakan perintah berikut di CMD / PowerShell jika ingin menghentikan service:
```cmd
taskkill /f /im pythonw.exe
```

#### 🚀 Mengaktifkan Autostart saat Startup Windows
1. Klik dua kali pada file `install_autostart.bat`.
2. Skrip akan membuat pintasan di folder Windows Startup secara otomatis (`runner.vbs`).
3. Service akan berjalan senyap di background secara otomatis setiap komputer menyala.

#### ❌ Menghentikan Autostart
Jika ingin menghapus dari startup, klik dua kali pada file `uninstall_autostart.bat`.

---

## 🧪 Menguji & Unit Testing

Untuk memastikan seluruh modul, tab filter, dan single-instance lock berjalan lancar:
```bash
python -m unittest discover -s tests
```

---

## 📄 Lisensi
Free to use & customizable! Bebas dikembangkan sesuai selera.
