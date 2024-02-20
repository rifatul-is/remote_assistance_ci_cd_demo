cd ~/Library/Android/sdk/emulator
./emulator -list-avds
AVD_NAME=$(./emulator -list-avds)
adb devices
./emulator -avd "$AVD_NAME" -no-snapshot-load & disown
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
adb devices
#pushd "/Users/rifatulislamramim/Downloads/Katalon_Studio_Engine_MacOS-8.6.8/Katalon Studio Engine.app/Contents/MacOS"
#echo "Running Tests"
#./katalonc -noSplash -runMode=console -projectPath="/Users/rifatulislamramim/Katalon Studio/Test/Test.prj" -retry=0 -testSuitePath="Test Suites/Remote Assistance Demo Test" -browserType="Android" -deviceId="emulator-5554" -executionProfile="default" -apiKey="85c71a78-37fe-491c-8054-e9409964c277" --config -proxy.auth.option=NO_PROXY -proxy.system.option=NO_PROXY -proxy.system.applyToDesiredCapabilities=true -webui.autoUpdateDrivers=true -appiumDirectory="/opt/homebrew/lib/node_modules/appium"
##kill
#popd
#adb -s emulator-5554 emu kill
