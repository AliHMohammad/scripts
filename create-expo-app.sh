#!/bin/bash

set -e

echo Project name?:
read name
echo 'Template? (default, blank, blank-typescript)':
read template
echo Relative path?
read dir
echo Do you want to install TailWindCSS? '(y/n)'
read twcss

cd $dir

echo =======================================
echo
echo Creating $template expo app at "$PWD"/$name - Continue? '(y/n)'
echo
echo =======================================


read input

if [ "$input" != 'y' ]; then
  echo Exiting script. Have a good day.
  exit
fi

echo Creating app..
npx create-expo-app $name --template $template

cd ./$name

npm i -g expo-cli
npx expo install react-dom@18.2.0 react-native-web @expo/metro-runtime


# Tailwind install

if [ "$twcss" == 'y' ]; then
  echo Installing TailwindCSS..

  npm install nativewind
  npm install --save-dev tailwindcss@3.3.2

  npx tailwindcss init
  sed -i 's|content: \[\],|content: ["./App.{js,jsx,ts,tsx}", "./components/*.{js,jsx,ts,tsx}", "./screens/*.{js,jsx,ts,tsx}"],|' tailwind.config.js

  # TODO: Insert fix for babel config
  # sed -i 's|presets: \["babel-preset-expo"\],| presets: ['babel-preset-expo'], plugins: ["nativewind/babel"],|' babel.config.js

  # TODO: Insert fix for import tailwind
  # if [ "$template" == 'default' ]; then
  #   cd ./app/\(tabs\)
  #   sed -i 's|import { NativeWindStyleSheet } from "nativewind";|import { NativeWindStyleSheet } from "nativewind";\nNativeWindStyleSheet.setOutput({\n  default: "native",\n});|' _layout.tsx
  # elif [ "$template" == 'blank' ]; then
  #   sed -i 's|import { NativeWindStyleSheet } from "nativewind";|import { NativeWindStyleSheet } from "nativewind";\nNativeWindStyleSheet.setOutput({\n  default: "native",\n});|' App.js
  # else
  #   sed -i 's|import { NativeWindStyleSheet } from "nativewind";|import { NativeWindStyleSheet } from "nativewind";\nNativeWindStyleSheet.setOutput({\n  default: "native",\n});|' App.tsx
  # fi
fi



echo =======================================
echo =================DONE!=================
echo =======================================
echo 
echo cd to $PWD and run 'npx expo start':

