# install fzf using init_fzf.sh script first
git clone https://github.com/lincheney/fzf-tab-completion.git ~/software/fzf_tab_completion

# Use readline for bash (more) environment
#   build readline
# cd  ~/software/fzf_tab_completion/readline/ && cargo build --release
#   create ~/.inputrc
# cat << 'EOF' > ~/.inputrc
# $include function rl_custom_complete $HOME/software/fzf_tab_completion/readline/target/release/librl_custom_complete.so
# "\t": rl_custom_complete
# EOF
