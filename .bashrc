# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# .bashrc_conf: complete setup
if [ -f ~/software/linux_minimalist_conf/.bashrc_conf ]; then
    .  ~/software/linux_minimalist_conf/.bashrc_conf
fi