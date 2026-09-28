# 🖥️ Terminal Discord Rich Presence

Aplikasi Discord Rich Presence yang ringan, kreatif, interaktif, dan menjaga privasi untuk **Windows Terminal**, **PowerShell**, dan **Command Prompt (CMD)**!

---

## ✨ Fitur Utama

- ⚡ **Ringan & Cepat**: Menggunakan IPC socket/pipe bawaan tanpa pustaka berat.
- 🎨 **Interaktif & Aesthetic**: Menampilkan status shell aktif (PowerShell ⚡, CMD 💻, WSL 🐧, Terminal 🖥️), jumlah tab aktif, dan direktori kerja saat ini.
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

### 2. Konfigurasi Client ID & Mode Privasi
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
  }
}
```

---

### 3. Integrasi Shell Profile (Mendukung Deteksi Folder Aktif)

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

### 4. Menjalankan & Autostart saat Windows Startup

#### 🏃 Menjalankan Manual
Jalankan file Python utama:
```bash
python terminal_rpc.py
```
Atau tanpa jendela konsol:
```cmd
pythonw terminal_rpc.py
```

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
