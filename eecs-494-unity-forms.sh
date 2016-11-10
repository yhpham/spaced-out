#!/bin/bash

# eecs-494-unity-forms.sh Version 1.5

DP0=$(pwd)
TURNIN=$1
UNITY=/Applications/Unity/Unity.app/Contents/MacOS/Unity
ZIP=/Applications/Keka.app/Contents/Resources/keka7z

ZIPFILE=$TURNIN.7z
APP=$TURNIN.app
EXE=$TURNIN.exe
EXEDATA=${TURNIN}_Data
EL=0

if [ "$1" == "" ]; then
  echo
  echo "Usage: sh ./eecs-494-unity-forms.sh TURNIN_NAME"
  echo
  exit 1
fi

for dir in $(ls -d "$APP" "$EXEDATA" 2> /dev/null); do rm -r $dir; done
for file in $(ls "$ZIPFILE" "$EXE" 2> /dev/null); do rm $file; done

echo "$UNITY" -quit -batchmode -buildOSXUniversalPlayer "$DP0/$APP" -buildWindowsPlayer "$DP0/$EXE" -projectPath "$DP0"
"$UNITY" -quit -batchmode -buildOSXUniversalPlayer "$DP0/$APP" -buildWindowsPlayer "$DP0/$EXE" -projectPath "$DP0"
EL=$?
if [ $EL -ne 0 ]; then
  echo Build failed.
else
  if [ $EL -eq 0 ]; then
    echo "$ZIP" a "$ZIPFILE" "$APP" "$EXE" "$EXEDATA"
    "$ZIP" a "$ZIPFILE" "$APP" "$EXE" "$EXEDATA"
    EL=$?
  fi

  for dir in $(ls -d "$APP" "$EXEDATA" 2> /dev/null); do rm -r $dir; done
  for file in $(ls "$EXE" 2> /dev/null); do rm $file; done
fi

echo ""

if [ $EL -eq 0 ]; then
  shasum -a 512 "$ZIPFILE"
else
  echo Something went wrong. See above for details.
fi

exit
