#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 Starting CarlTweaks Automated Installation..."

# 1. Standard Update & Dependency Install
apt-get update
apt-get --assume-yes upgrade
apt-get --assume-yes install coreutils gnupg wget jq termux-api android-tools -y

# 2. Inject CarlTweaks Auto-Detect Logic
echo "🛠️ Injecting CarlTweaks Auto-Detect Logic..."

# Rename original binaries to -raw
mv $PREFIX/bin/adb $PREFIX/bin/adb-raw 2>/dev/null
mv $PREFIX/bin/fastboot $PREFIX/bin/fastboot-raw 2>/dev/null

# Create the ADB wrapper with "No Device" alert
cat << 'EOF' > $PREFIX/bin/adb
#!/data/data/com.termux/files/usr/bin/bash
USB_PATH=$(termux-usb -l | jq -r '.[0]' 2>/dev/null)
if [ -z "$USB_PATH" ] || [ "$USB_PATH" == "null" ]; then
    echo "⚠️ [CarlTweaks] No OTG device detected. Please connect your device and check OTG settings."
    adb-raw "$@"
else
    termux-usb -r "$USB_PATH" 2>/dev/null
    adb-raw -t "$USB_PATH" "$@"
fi
EOF

# Create the Fastboot wrapper with "No Device" alert
cat << 'EOF' > $PREFIX/bin/fastboot
#!/data/data/com.termux/files/usr/bin/bash
USB_PATH=$(termux-usb -l | jq -r '.[0]' 2>/dev/null)
if [ -z "$USB_PATH" ] || [ "$USB_PATH" == "null" ]; then
    echo "⚠️ [CarlTweaks] No OTG device detected. Please connect your device and check OTG settings."
    fastboot-raw "$@"
else
    termux-usb -r "$USB_PATH" 2>/dev/null
    fastboot-raw -t "$USB_PATH" "$@"
fi
EOF

# 3. Set Permissions
chmod +x $PREFIX/bin/adb $PREFIX/bin/adb-raw $PREFIX/bin/fastboot $PREFIX/bin/fastboot-raw

echo "✅ CarlTweaks ADB & Fastboot Integration Complete!"
echo "💡 Try typing 'adb devices' or 'fastboot devices' now."
