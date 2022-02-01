#!/usr/bin/env bash

# Jenv - auto switching between jvms (https://www.jenv.be/)

# Setup jenv
brew install jenv

echo "Adding temurin 8 to jenv"
jenv add /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home

echo "Adding temurin 11 to jenv"
jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home

echo "Adding temurin 17 to jenv"
jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

# This could be made generic by having the user select from a list of "jenv versions"
echo "Setting global java version to 11.0.14"
jenv global 11.0.14

echo "Enable maven plugin that makes jenv take control of java version for maven"
jenv sh-enable-plugin maven
echo "Enable export plugin that makes jenv take control of java version for JAVA_HOME"
jenv sh-enable-plugin export

echo "Calling the jenv doctor to make sure everything is all right"
jenv doctor
echo "Note that 'No JAVA_HOME set' is OK as the export plugin requires a new session to take effect"