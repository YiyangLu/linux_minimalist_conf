# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# .bashrc_conf: complete setup
if [ -f ~/.bashrc_conf ]; then
    . ~/.bashrc_conf
fi

# .bashrc_conf: minimal setup without color/alias setup
# if [ -f ~/.bashrc_conf ]; then
#     . ~/.bashrc_conf
# fi