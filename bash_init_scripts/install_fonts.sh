# Download the font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
mkdir -p CascadiaCode
unzip CascadiaCode.zip -d CascadiaCode
# rm -rf ~/.local/share/fonts/
# mkdir -p ~/.local/share/fonts
mv CascadiaCode/*.ttf ~/.local/share/fonts/
fc-cache -fv
rm -rf CascadiaCode CascadiaCode.zip