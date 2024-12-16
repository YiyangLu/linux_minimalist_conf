# inshellisense provides IDE style autocomplete for shells. It's a terminal native runtime for autocomplete which has support for 600+ command line tools. inshellisense supports Windows, Linux, & macOS.
# https://github.com/microsoft/inshellisense

# Install Node.js and npm
## installs fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash
## activate fnm
source ~/.bashrc
## download and install Node.js
fnm use --install-if-missing 20

# Install inshellisense
npm install -g @microsoft/inshellisense
# Add to bash
is init bash >> ~/.bashrc
