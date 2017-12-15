#!/usr/bin/fish

abbr -a la ls -l
abbr -a lsa ls -al
abbr -a v vim

function vrc
  if [ -d ~/.vim ]
    vim ~/.vim/vimrc
  else
    vim ~/.vimrc
  end
end

