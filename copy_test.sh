TARGET_DIRECTORY="/Users/rifatulislamramim/Downloads/Katalon_Studio_Engine_MacOS-7.5.5/.katalon"
SOURCE_DIRECTORY="/Users/rifatulislamramim/AndroidStudioProjects/remote_assistance_ci_cd_demo/.katalon" # Replace this with the actual source directory path
if [ -d "$TARGET_DIRECTORY" ]; then
  echo "The directory $TARGET_DIRECTORY exists."
else
  echo "The directory $TARGET_DIRECTORY does not exist. Copying from $SOURCE_DIRECTORY..."
  cp -r "$SOURCE_DIRECTORY" "$TARGET_DIRECTORY"
  echo "Copy completed."
fi