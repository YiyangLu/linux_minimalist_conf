git clone https://github.com/lincheney/fzf-tab-completion.git ~/Software/fzf_tab_completion
# Add to ~/.bashrc
echo 'source ~/Software/fzf_tab_completion/bash/fzf-bash-completion.sh' >> ~/.bashrc
echo 'bind -x '"\t": fzf_bash_completion'' >> ~/.bashrc