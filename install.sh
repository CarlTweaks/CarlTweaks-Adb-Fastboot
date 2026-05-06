#!/data/data/com.termux/files/usr/bin/bash

# 1. Standard Updates & Dependencies
apt-get update
apt-get --assume-yes upgrade
apt-get --assume-yes install coreutils gnupg wget jq termux-api -y

# 2. Rendiix Repo Installation
if [ ! -f "$PREFIX/etc/apt/sources.list.d/rendiix.list" ]; then
  mkdir -p $PREFIX/etc/apt/sources.list.d
  echo "deb https://rendiix.github.io android-tools main" > $PREFIX/etc/apt/sources.list.d/rendiix.list
  wget -qP $PREFIX/etc/apt/trusted.gpg.d https://rendiix.github.io/rendiix.gpg
  apt update
  apt install platform-tools -y
else
  echo "Repo already installed. Updating tools..."
  apt install platform-tools -y
fi

# 3. --- CarlTweaks "gfastboot" Logic Injection ---
# Dito na papasok yung galing ni gfastboot para sa ADB at Fastboot
echo "Injecting CarlTweaks Auto-Detect Logic..."

for tool in adb fastboot; do
    # Itago ang original binary
    if [ -f "$PREFIX/bin/$tool" ] && [ ! -f "$PREFIX/bin/$tool-raw" ]; then
        mv $PREFIX/bin/$tool $PREFIX/bin/$tool-raw
    fi

    # Gawin ang wrapper (ito yung 'gfastboot' logic mo)
    cat <<EOF > $PREFIX/bin/$tool
#!/data/data/com.termux/files/usr/bin/bash
# CarlTweaks Auto-Detect Wrapper for $tool
USB_PATH=\$(termux-usb -l | jq -r '.[0]')
if [ "\$USB_PATH" != "null" ] && [ -n "\$USB_PATH" ]; then
    termux-usb -r "\$USB_PATH" -e "$PREFIX/bin/$tool-raw \$@"
else
    echo "❌ [CarlTweaks] Error: No device found. Check OTG/Cable."
    exit 1
fi
EOF
    chmod +x $PREFIX/bin/$tool
    chmod +x $PREFIX/bin/$tool-raw
done

echo "✅ CarlTweaks ADB & Fastboot Integration Complete!"
echo "You can now use 'adb' or 'fastboot' directly."
