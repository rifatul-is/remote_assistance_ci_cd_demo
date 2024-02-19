#!/bin/bash

# Set up environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Install Command Line Tools if not already installed
if [ ! -d $ANDROID_HOME/cmdline-tools/latest ]; then
  echo "Downloading Command Line Tools"
  mkdir -p $ANDROID_HOME/cmdline-tools
  cd $ANDROID_HOME/cmdline-tools
  wget https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip
  unzip commandlinetools-mac-7302050_latest.zip
  mv cmdline-tools latest
  rm commandlinetools-mac-7302050_latest.zip
fi

# Accept licenses
yes | sdkmanager --licenses

# Install necessary SDK packages
sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "emulator" "system-images;android-30;google_apis;x86_64"

# Create an AVD
echo "no" | avdmanager create avd -n testEmulator -k "system-images;android-30;google_apis;x86_64" --force
