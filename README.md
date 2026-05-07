# 🛠️ CarlTweaks ADB & Fastboot Wrapper

A smart, automated wrapper for **ADB** and **Fastboot** on Termux (Android-to-Android modding). This tool is based on the platform-tools from Rendiix but enhanced with **CarlTweaks Auto-Detect Logic** to eliminate the need for manual USB path addressing.

## 🚀 Features
- **Auto-Detect USB Path:** No more checking for `/dev/bus/usb/00x/00x`. The script finds the device for you.
- **Auto-Permission Prompt:** Automatically triggers the Termux-USB permission dialog.
- **Integrated ADB & Fastboot:** Both tools are wrapped with the same smart logic.
- **One-Line Installation:** Simple setup via `curl`.

## 📦 Installation

Copy and paste the command below into your Termux:

```bash
curl -sL [https://raw.githubusercontent.com/CarlTweaks/CarlTweaks-Adb-Fastboot/refs/heads/main/install.sh](https://raw.githubusercontent.com/CarlTweaks/CarlTweaks-Adb-Fastboot/refs/heads/main/install.sh) | bash
