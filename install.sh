
if [ ! -f ~/.profile ]; then
  ln -s `pwd`/bash/bashrc ~/.profile
fi
if [ ! -f ~/.inputrc ]; then
  ln -s `pwd`/bash/inputrc ~/.inputrc
fi
if [ ! -f ~/.vimrc ]; then
  ln -s `pwd`/vim/vimrc ~/.vimrc
fi
if [ ! -f ~/.tmux.conf ]; then
  ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
fi
