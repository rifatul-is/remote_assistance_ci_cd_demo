#!/bin/bash

# Set up environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Create an AVD if it doesn't exist
AVD_NAME="testEmulator"
if [ ! -d $HOME/.android/avd/${AVD_NAME}.avd ]; then
  echo "Creating AVD named ${AVD_NAME}"
  echo "no" | avdmanager create avd -n $AVD_NAME -k "system-images;android-30;google_apis;x86_64" --force
else
  echo "AVD ${AVD_NAME} already exists"
fi

# Start the emulator in the background
echo "Starting emulator for ${AVD_NAME}"
nohup emulator -avd $AVD_NAME -no-audio -no-window &
EMULATOR_PID=$!

# Wait for the emulator to start
$ANDROID_HOME/platform-tools/adb wait-for-device

echo "Emulator started"

# Optional: Unlock the screen (useful for some system images)
$ANDROID_HOME/platform-tools/adb shell input keyevent 82 &

# Wait a bit for the emulator to fully start
sleep 30

echo "Emulator should be ready"