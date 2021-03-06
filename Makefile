install: install-vim install-konsole install-dotfiles

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

install-konsole:
	rm -rf ~/.kde/share/apps/konsole/ignacy.colorscheme ~/.kde/share/apps/konsole/Default.profile
	ln -s `pwd`/konsole/ignacy.colorscheme ~/.kde/share/apps/konsole/ignacy.colorscheme
	ln -s `pwd`/konsole/Default.profile ~/.kde/share/apps/konsole/Default.profile

install-dotfiles:
	rm -rf ~/.bashrc ~/.bash ~/.bash_aliases ~/.bash_completion ~/.inputrc ~/.gitconfig ~/.htoprc ~/.tmux.conf
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash ~/.bash
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/bash_completion ~/.bash_completion
	ln -s `pwd`/inputrc ~/.inputrc
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/htoprc ~/.htoprc
	ln -s `pwd`/tmux.conf ~/.tmux.conf

