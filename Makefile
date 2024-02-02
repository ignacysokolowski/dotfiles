install: install-vim install-karabiner install-dotfiles

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

install-karabiner:
	rm -rf ~/.config/karabiner
	ln -s `pwd`/karabiner ~/.config/karabiner

install-dotfiles:
	rm -rf ~/.bashrc ~/.bash ~/.bash_completion ~/.inputrc ~/.gitconfig ~/.htoprc ~/.tmux.conf ~/.ideavimrc
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash ~/.bash
	ln -s `pwd`/bash_completion ~/.bash_completion
	ln -s `pwd`/inputrc ~/.inputrc
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/htoprc ~/.htoprc
	ln -s `pwd`/tmux.conf ~/.tmux.conf
	ln -s `pwd`/ideavimrc ~/.ideavimrc

