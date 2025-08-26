#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}GitHub CLI Installation Script${NC}"
echo "================================"

# Detect architecture
ARCH=$(uname -m)
OS="linux"

case $ARCH in
    x86_64)
        ARCH_STRING="amd64"
        ;;
    aarch64|arm64)
        ARCH_STRING="arm64"
        ;;
    armv7l)
        ARCH_STRING="armv6"
        ;;
    *)
        echo -e "${RED}Unsupported architecture: $ARCH${NC}"
        exit 1
        ;;
esac

# Get the latest version from GitHub API
echo -e "${YELLOW}Fetching latest GitHub CLI version...${NC}"
LATEST_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo -e "${RED}Failed to fetch latest version. Using fallback version 2.78.0${NC}"
    LATEST_VERSION="2.78.0"
fi

echo -e "${GREEN}Latest version: v$LATEST_VERSION${NC}"

# Check if gh is already installed and get current version
if command -v gh &> /dev/null; then
    CURRENT_VERSION=$(gh --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    echo -e "${YELLOW}Current installed version: v$CURRENT_VERSION${NC}"
    
    if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
        echo -e "${GREEN}GitHub CLI is already up to date!${NC}"
        exit 0
    else
        echo -e "${YELLOW}Upgrading from v$CURRENT_VERSION to v$LATEST_VERSION${NC}"
    fi
else
    echo -e "${YELLOW}GitHub CLI not found. Installing v$LATEST_VERSION${NC}"
fi

# Create local bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Create temp directory for download
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download the release
DOWNLOAD_URL="https://github.com/cli/cli/releases/download/v${LATEST_VERSION}/gh_${LATEST_VERSION}_${OS}_${ARCH_STRING}.tar.gz"
echo -e "${YELLOW}Downloading from: $DOWNLOAD_URL${NC}"

if ! wget -q --show-progress "$DOWNLOAD_URL"; then
    echo -e "${RED}Failed to download GitHub CLI${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Extract
echo -e "${YELLOW}Extracting archive...${NC}"
tar xzf "gh_${LATEST_VERSION}_${OS}_${ARCH_STRING}.tar.gz"

# Move the binary to local bin
echo -e "${YELLOW}Installing binary...${NC}"
cp "gh_${LATEST_VERSION}_${OS}_${ARCH_STRING}/bin/gh" ~/.local/bin/
chmod +x ~/.local/bin/gh

# Clean up
cd ~
rm -rf "$TEMP_DIR"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Adding ~/.local/bin to PATH...${NC}"
    
    # Determine which shell config file to use
    if [ -f ~/.bashrc ]; then
        SHELL_CONFIG=~/.bashrc
    elif [ -f ~/.zshrc ]; then
        SHELL_CONFIG=~/.zshrc
    else
        SHELL_CONFIG=~/.profile
    fi
    
    # Check if the PATH export already exists in the file
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG"; then
        # Ensure there's a newline before adding our line
        if [ -s "$SHELL_CONFIG" ] && [ "$(tail -c 1 "$SHELL_CONFIG" | wc -l)" -eq 0 ]; then
            echo "" >> "$SHELL_CONFIG"
        fi
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
        echo -e "${GREEN}PATH updated in $SHELL_CONFIG${NC}"
        echo -e "${YELLOW}Please run: source $SHELL_CONFIG${NC}"
    fi
    
    # Export for current session and source to test like user would
    export PATH="$HOME/.local/bin:$PATH"
    source "$SHELL_CONFIG" 2>/dev/null || true
else
    echo -e "${GREEN}~/.local/bin is already in PATH${NC}"
fi

# Verify installation using source-updated PATH
if command -v gh &> /dev/null && gh --version &> /dev/null; then
    INSTALLED_VERSION=$(~/.local/bin/gh --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    echo -e "${GREEN}✓ GitHub CLI v$INSTALLED_VERSION installed successfully!${NC}"
    echo -e "${YELLOW}You can now use 'gh' command${NC}"
    
    # Check if user needs to authenticate
    if ! ~/.local/bin/gh auth status &> /dev/null; then
        echo ""
        echo -e "${YELLOW}To authenticate with GitHub, run:${NC}"
        echo "  gh auth login"
    fi
else
    echo -e "${RED}Installation verification failed${NC}"
    exit 1
fi