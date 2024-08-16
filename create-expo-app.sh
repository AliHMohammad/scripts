#!/bin/bash

set -e

#TODO: Option for tailwind


echo Project name?:
read name
echo 'Template? (default, blank, blank-typescript)':
read template
echo Relative path?
read dir

cd $dir

echo =======================================
echo Creating $template expo app at "$PWD"/$name - Continue? '(y/n)'
echo =======================================

read input

if [ $input != 'y' ]; then
  echo Exiting script. Have a good day.
  exit
fi

npx create-expo-app $name --template $template

cd ./$name

npm i -g expo-cli
npx expo install react-dom@18.2.0 react-native-web @expo/metro-runtime

echo =======================================
echo =================DONE!=================
echo =======================================
echo 
echo cd to $PWD and run 'npx expo start':
