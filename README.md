# ⚡ Ultra-Lightweight Zero-Bloat Cloud ERP System

[![Cloud Release Builds](https://github.com/MuhammedFawzyShoaib/erp-system/actions/workflows/release_builds.yml/badge.svg)](https://github.com/MuhammedFawzyShoaib/erp-system/actions/workflows/release_builds.yml)

A high-performance, modular Enterprise Resource Planning (ERP) platform engineered with **Golang Fiber**, **Supabase Cloud PostgreSQL**, and **Flutter Web**.

Strictly engineered for developer machines with **almost ZERO free disk space**.

---

## 🏛️ The 3 Zero-Disk-Space Engineering Pillars

### 1. Cloud Database via Supabase (0 MB Local Storage)
- **Zero Local Footprint:** Eliminates Docker, local PostgreSQL daemon, and data volume disks.
- **Instant Cloud Deployment:** A single SQL script (`supabase_init.sql`) pasted into the Supabase SQL Editor.
- **Enterprise Core Modules:** Includes `roles`, `users`, `products`, `customers`, `invoices`, `accounts`, and `employees`.
- **Zero Heavy ORMs:** Pure standard `database/sql` + `github.com/lib/pq` with resilient connection pooling and graceful offline memory fallback.

### 2. Local Testing via Flutter Web / Chrome (No Multi-GB Build Directories)
- **Zero Local Compilation Disk Overhead:** Avoids generating massive multi-gigabyte Android SDK or Windows C++ desktop `build/` directories.
- **Runs Directly in Chrome:** Run instantly with:
  ```bash
  cd frontend
  flutter run -d chrome --no-pub
  ```
- **Universal CORS Setup:** The Go Fiber server is configured with permissive CORS (`AllowOrigins: "*"`, `AllowHeaders: "Origin, Content-Type, Accept, Authorization"`) allowing Chrome running on random ports to talk to the backend without issues.
- **Minimal Dependencies:** Built solely with Flutter Material 3, `ValueNotifier` state management, and `http`. No `build_runner`, `freezed`, custom fonts, or heavy asset bundles.

### 3. Cloud Compilation via GitHub Actions (0 MB Local Build Overhead)
- **Automated Cloud Workflows:** Compiles binaries on GitHub's cloud runners:
  - **Windows Desktop:** `flutter build windows --release` zipped bundle
  - **Linux Desktop:** `flutter build linux --release` tarball
  - **Android APK:** `flutter build apk --release`
  - **Golang Backend:** Stripped Windows `.exe` & Linux binary
- **Instant Downloads:** Binaries uploaded to GitHub Workflow Artifacts (`actions/upload-artifact@v4`).

---

## 📁 Compact Project Structure

```text
ERP_SYS/
├── .github/
│   └── workflows/
│       └── release_builds.yml    # Cloud compilation for Windows, Linux, Android, Go
├── backend/
│   ├── go.mod                    # Lightweight dependencies (Fiber, JWT, lib/pq, bcrypt)
│   └── main.go                   # High-performance Go Fiber server & API endpoints
├── frontend/
│   ├── lib/
│   │   └── main.dart             # Responsive Flutter ERP (Dashboard, Inventory, POS, GL, HR)
│   └── pubspec.yaml              # Lightweight manifest (http package only)
├── .gitignore                    # Blocks build/, .dart_tool/, and binary bloat
├── setup_and_push.sh             # Single bash installer & git pusher
├── supabase_init.sql             # Complete PostgreSQL schema + 1 test row per table
└── README.md
```

---

## 🚀 Quick Start Guide

### Step 1: Initialize Cloud Database (Supabase)
1. Log into your [Supabase Dashboard](https://supabase.com).
2. Open the **SQL Editor** in your Supabase project.
3. Paste the contents of `supabase_init.sql` and click **Run**.
4. Retrieve your Connection String from **Project Settings > Database > Connection string (URI)**.
   Ensure `sslmode=require` is present.

### Step 2: Start the Go Fiber Backend
```bash
cd backend
export DATABASE_URL="postgres://postgres:[YOUR-PASSWORD]@[YOUR-SUBDOMAIN].pooler.supabase.com:6543/postgres?sslmode=require"
go run main.go
```
*Note: If `DATABASE_URL` is omitted, the server runs in resilient in-memory mode seeded with the exact test records.*

### Step 3: Run the Flutter Frontend in Chrome
```bash
cd frontend
flutter run -d chrome
```

### Default Credentials
- **Username:** `admin` (or `admin@erp.local`)
- **Password:** `admin123`
