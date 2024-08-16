#!/bin/bash

set -e

#TODO: Option for tailwind


echo Project name?:
read name
echo 'Template? (default, blank, blank-typescript)':
read template
echo Directory?
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

npm update
npm i -g expo-cli

cp app.json app.json.tmp &&
jq '.expo.web += {"bundler": "metro"}' app.json.tmp >app.json &&
rm app.json.tmp

npx expo install react-native-web@~0.19.6 react-dom@18.2.0


echo =======================================
echo =======================================

echo DONE!
echo cd to ./$name and run 'npx expo' to start your application

echo =======================================
echo =======================================
