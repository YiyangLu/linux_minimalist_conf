#!/bin/bash

# Get the architecture of the machine
arch=$(uname -m)
os=$(uname -s)

# Download the Zellij binary
if [ "$os" == "Darwin" ]; then
  filename="zellij-${arch}-apple-darwin.tar.gz"
  url="https://github.com/zellij-org/zellij/releases/latest/download/$filename"
  echo "Downloading Zellij binary for macOS..."
  curl -LO "$url"
else
  if [ "$os" == "Linux" ]; then
    filename="zellij-${arch}-unknown-linux-musl.tar.gz"
    url="https://github.com/zellij-org/zellij/releases/latest/download/$filename"
    echo "Downloading Zellij binary for Linux..."
    curl -LO "$url"
  else
    echo "Unsupported OS: $os"
  fi
fi

# Create the target directory if it doesn't exist
mkdir -p ~/software/Zellij

# Uncompress the Zellij binary
echo "Uncompressing Zellij binary..."
tar -xf "$filename" -C ~/software/Zellij


# add the Zellij binary to the PATH
echo "Adding Zellij binary to PATH..."
if [ "$os" == "Linux" ]; then
  echo 'export PATH="$PATH:$HOME/software/Zellij"' >> ~/.bashrc
else
  echo 'export PATH="$PATH:$HOME/software/Zellij"' >> ~/.bash_profile
fi

# Remove the .tar.gz file
echo "Removing .tar.gz file..."
rm "$filename"

# Check if the Zellij binary exists
# if [ -f "/bin/zellij" ]; then
#   echo "Zellij binary installed successfully!"
# else
#   echo "Zellij binary not installed successfully!"
# fi