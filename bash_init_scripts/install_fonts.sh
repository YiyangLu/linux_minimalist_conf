# Download the font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
mkdir -p Hack
unzip Hack.zip -d Hack
rm -rf ~/.local/share/fonts/
mkdir -p ~/.local/share/fonts
mv Hack/*.ttf ~/.local/share/fonts/
fc-cache -fv
rm -rf Hack Hack.zip