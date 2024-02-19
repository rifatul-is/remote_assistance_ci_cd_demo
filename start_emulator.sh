#!/bin/bash

# Set up environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Download and unzip Android Command Line Tools if not already installed
if [ ! -d $ANDROID_HOME/cmdline-tools/latest ]; then
  echo "Downloading Command Line Tools"
  mkdir -p $ANDROID_HOME/cmdline-tools
  cd $ANDROID_HOME/cmdline-tools
  curl -O https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip
  unzip commandlinetools-mac-7302050_latest.zip -d latest
  rm commandlinetools-mac-7302050_latest.zip
  cd -
fi

# Accept licenses
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

# Install necessary SDK packages
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "emulator" "system-images;android-30;google_apis;x86_64"

# Check if AVD already exists and delete it if so
avdmanager list avd | grep "testEmulator" && avdmanager delete avd -n testEmulator

# Create a new AVD
echo "no" | avdmanager create avd -n testEmulator -k "system-images;android-30;google_apis;x86_64" --force

# Start the emulator in headless mode
$ANDROID_HOME/emulator/emulator -avd testEmulator -no-window -no-audio -no-boot-anim &
# Wait for the emulator to finish booting
$ANDROID_HOME/platform-tools/adb wait-for-device

# Optional: Check for the device's boot completion (useful for running automated tests afterwards)
$ANDROID_HOME/platform-tools/adb shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
