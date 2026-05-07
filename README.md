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

## ⚠️ Requirements

Before using the tool, ensure you have the following:

* **Termux-API (App):** Must be installed on your device. Download it via [F-Droid](https://f-droid.org/en/packages/com.termux.api/) or GitHub.
* **OTG Cable/Adapter:** Required to connect the two Android devices.
* **USB Debugging:** Must be enabled in "Developer Options" on the target device (for ADB use).

---

## 📖 Instructions (How to Use)

Follow these simple steps to use CarlTweaks:

### 1. Hardware Connection
* Plug the OTG adapter into your **Host Phone** (where Termux is installed).
* Connect the other end to the **Target Device** you want to mod.

### 2. Authorization
* Type `fastboot devices` or `adb devices` in Termux.
* A **Termux-USB permission prompt** will appear; click **OK**.
* (For ADB) An **RSA Authorization** prompt will appear on the target device's screen; click **Allow**.

### 3. Running Commands
* You can now run standard commands without manually inputting the USB path.
* *Example:* `fastboot flash recovery recovery.img` or `adb shell`.

---
**Maintained by [CarlTweaks](https://github.com/CarlTweaks)**
