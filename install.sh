#!/data/data/com.termux/files/usr/bin/bash

# =========================================================
# CarlTweaks ADB & Fastboot Automated Wrapper
# =========================================================

echo "🚀 Starting CarlTweaks Automated Installation..."

# 1. Update and Install Dependencies
echo "📦 Updating packages and installing tools..."
apt-get update
apt-get --assume-yes upgrade
apt-get --assume-yes install coreutils gnupg wget jq termux-api android-tools -y

# 2. Check if tools were installed successfully
if [ ! -f "$PREFIX/bin/adb" ] || [ ! -f "$PREFIX/bin/fastboot" ]; then
    echo "❌ Error: Failed to install android-tools. Please check your internet connection."
    exit 1
fi

# 3. Inject CarlTweaks Auto-Detect Logic
echo "🛠️ Injecting CarlTweaks Auto-Detect Logic..."

# Rename original binaries to -raw (para hindi mag-loop)
mv $PREFIX/bin/adb $PREFIX/bin/adb-raw 2>/dev/null
mv $PREFIX/bin/fastboot $PREFIX/bin/fastboot-raw 2>/dev/null

# Create the ADB wrapper
cat << 'EOF' > $PREFIX/bin/adb
#!/data/data/com.termux/files/usr/bin/bash
USB_PATH=$(termux-usb -l | jq -r '.[0]' 2>/dev/null)
if [ -z "$USB_PATH" ] || [ "$USB_PATH" == "null" ]; then
    # Warning message only for common device commands to avoid spam
    if [[ "$1" == "devices" || "$1" == "shell" || "$1" == "push" ]]; then
        echo "⚠️ [CarlTweaks] No OTG device detected."
    fi
    adb-raw "$@"
else
    termux-usb -r "$USB_PATH" 2>/dev/null
    adb-raw -t "$USB_PATH" "$@"
fi
EOF

# Create the Fastboot wrapper
cat << 'EOF' > $PREFIX/bin/fastboot
#!/data/data/com.termux/files/usr/bin/bash
USB_PATH=$(termux-usb -l | jq -r '.[0]' 2>/dev/null)
if [ -z "$USB_PATH" ] || [ "$USB_PATH" == "null" ]; then
    if [[ "$1" == "devices" || "$1" == "flash" || "$1" == "reboot" ]]; then
        echo "⚠️ [CarlTweaks] No OTG device detected."
    fi
    fastboot-raw "$@"
else
    termux-usb -r "$USB_PATH" 2>/dev/null
    fastboot-raw -t "$USB_PATH" "$@"
fi
EOF

# 4. Set Permissions
chmod +x $PREFIX/bin/adb $PREFIX/bin/adb-raw $PREFIX/bin/fastboot $PREFIX/bin/fastboot-raw

echo ""
echo "✅ CarlTweaks ADB & Fastboot Integration Complete!"
echo "💡 Use 'adb devices' or 'fastboot devices' to test."
