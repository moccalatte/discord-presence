# 🖥️ Terminal Discord Rich Presence

Aplikasi Discord Rich Presence yang ringan, kreatif, interaktif, dan menjaga privasi untuk **Windows Terminal**, **PowerShell**, dan **Command Prompt (CMD)**!

---

## ✨ Fitur Utama

- ⚡ **Ringan & Cepat**: Menggunakan IPC socket/pipe bawaan tanpa pustaka berat.
- 🎨 **Interaktif & Aesthetic**: Menampilkan status shell aktif (PowerShell ⚡, CMD 💻, WSL 🐧, Terminal 🖥️), jumlah tab aktif, context nama user/SSH (misal `morph@potion:`), dan direktori kerja saat ini.
- 🏷️ **Hover Title Custom**: Saat icon presence di-hover mouse di Discord, secara default akan menampilkan nama **Console**.
- 🔒 **Menjaga Privasi**:
  - `folder`: Hanya menampilkan nama folder/proyek aktif (contoh: `📁 my-project`).
  - `full`: Menampilkan direktori lengkap dengan penyamaan path rumah (`~`).
  - `hidden`: Hanya menampilkan `📁 Workspace`.
- 🚀 **Autostart**: Skrip installer otomatis agar berjalan tanpa jendela hitam (silent background) saat Windows dinyalakan.

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
*(Atau jika sudah download/unzip repo ini, buka folder project lalu ikuti panduan langkah di bawah)*

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

### 2. Konfigurasi Client ID, Assets, & Mode Privasi
Buka file `config.json` di folder utama project ini, ganti `client_id` dengan Application ID milikmu:

```json
{
  "client_id": "MASUKKAN_CLIENT_ID_DISCORD_KAMU_DISINI",
  "privacy_mode": "folder",
  "update_interval": 5,
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

### 3. Integrasi Shell Profile (Mendukung Deteksi Folder & Context User)

#### 🔹 Untuk PowerShell
1. Buka PowerShell dan ketik `notepad $PROFILE`.
2. Salin seluruh isi dari file `scripts/profile.ps1` dan tempelkan ke file `$PROFILE` kamu.
3. Simpan dan tutup Notepad. Setiap kali kamu berpindah direktori di PowerShell, status folder akan otomatis diperbarui di Discord!

#### 🔹 Untuk Command Prompt (CMD)
1. Buka CMD dan panggil skrip hook saat membuka prompt:
   ```cmd
   call scripts\cmd_prompt.cmd
   ```

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
Jika aplikasi berjalan di background via `pythonw.exe` dan kamu ingin menghentikannya:

**Via Command Prompt / PowerShell:**
```cmd
taskkill /f /im pythonw.exe
```

**Via Windows Task Manager:**
1. Tekan `Ctrl + Shift + Esc` untuk membuka Task Manager.
2. Cari **Python** atau **pythonw.exe** di daftar Processes.
3. Klik kanan lalu pilih **End Task**.

---

#### 🚀 Mengaktifkan Autostart saat Startup Windows
1. Klik dua kali pada file `install_autostart.bat`.
2. Skrip akan membuat pintasan di folder Windows Startup secara otomatis.
3. Aplikasi akan langsung berjalan di background secara senyap (silent mode via `runner.vbs`) saat komputer kamu menyala!

#### ❌ Menghentikan Autostart
Jika ingin menghapus dari startup, klik dua kali pada file `uninstall_autostart.bat`.

---

## 🧪 Menguji & Unit Testing

Untuk memastikan semua modul berjalan baik tanpa kesalahan:
```bash
python -m unittest discover -s tests
```

---

## 📄 Lisensi
Free to use & customizable! Bebas dikembangkan sesuai selera.
