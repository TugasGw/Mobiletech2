# KampusHub — GitHub Pages + Supabase

Versi ini mempertahankan HTML/CSS/JavaScript statis untuk hosting GitHub Pages. Supabase Auth mengelola akun; tabel `kampushub_data` menyimpan data tugas, kelompok, arsip, dan status per pengguna.

## 1. Buat proyek Supabase
1. Buat proyek di https://supabase.com/dashboard.
2. Di SQL Editor, jalankan seluruh isi `supabase-setup.sql`.
3. Di Project Settings / Connect, salin **Project URL** dan **publishable key** (umumnya diawali `sb_publishable_`, atau anon public key lama).
4. Isi dua nilai tersebut di `supabase-config.js`.
5. Jangan pernah menaruh `sb_secret_...` atau `service_role` key di file frontend. Jika key rahasia sempat dibagikan, rotasi/cabut dari dashboard.

## 2. Konfigurasi autentikasi
Di Supabase Authentication → URL Configuration, tambahkan URL GitHub Pages kamu ke Site URL / Redirect URLs. Misalnya `https://USERNAME.github.io/NAMA-REPO/` (ganti dengan URL asli).

Jika email confirmation aktif, pengguna harus mengonfirmasi email sebelum login. Atur SMTP/email sesuai kebutuhan dan pastikan URL redirect benar.

## 3. Unggah ke GitHub
Unggah/commit `index.html`, `style.css`, `app.js`, `supabase-config.js`, `supabase-setup.sql`, dan README ini ke repository. GitHub Pages akan menyajikan frontend; Supabase menyimpan akun/data. Tidak ada perubahan atau publikasi yang dilakukan otomatis oleh file ini.

## 4. Data dan batasan
- Akun lama yang tersimpan di `localStorage` tidak otomatis bermigrasi. Pengguna perlu mendaftar ulang di Supabase atau menyiapkan migrasi khusus.
- Data tugas disimpan sebagai satu JSON payload per akun, dengan RLS pada `user_id`.
- Lampiran yang dipilih masih disimpan sebagai data URL di payload. Ini cocok hanya untuk prototipe dengan file kecil; untuk pemakaian serius, pindahkan lampiran ke Supabase Storage dengan bucket privat dan policies.
- Username adalah metadata profil, bukan identitas login; login menggunakan email + password.
- Jangan gunakan data sensitif sungguhan sebelum menguji keamanan dan backup.

## 5. Tes
1. Buka website via HTTPS GitHub Pages.
2. Daftar menggunakan email, nama, username, dan password minimal 8 karakter.
3. Jika diminta, konfirmasi email.
4. Login, buat tugas, lalu logout.
5. Login ke akun yang sama dari perangkat/browser lain dan periksa tugas.
6. Buat akun kedua dan pastikan data akun pertama tidak terlihat.


## Perhatian
- `index.html` sudah memuat Supabase JS CDN, `supabase-config.js`, dan formulir email yang dibutuhkan Supabase Auth.
- Gunakan hanya Project URL dan publishable key (`sb_publishable_...`) di `supabase-config.js`. Jangan masukkan `sb_secret_...`.
