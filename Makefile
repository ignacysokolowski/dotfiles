install: install-vim install-sublime-text-2 install-dotfiles

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

install-sublime-text-2:
	rm -rf ~/.config/sublime-text-2/Packages/User
	ln -s `pwd`/sublime-text-2 ~/.config/sublime-text-2/Packages/User

install-dotfiles:
	rm -rf ~/.bash_aliases ~/.gitconfig
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/gitconfig ~/.gitconfig

