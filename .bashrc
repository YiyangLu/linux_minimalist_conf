# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source custom bashrc file
if [ -f ~/.bashrc_conf ]; then
    . ~/.bashrc_conf
fi
