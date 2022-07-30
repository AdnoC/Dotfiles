#!/bin/sh

mkdir -p win_vimrc

cp ~/WinUser/AppData/Local/nvim/init.vim win_vimrc/.vimrc
cp ~/WinUser/AppData/Local/nvim/.vimrc_plugin win_vimrc/.vimrc_plugin
cp ~/WinUser/AppData/Local/nvim/ginit.vim win_vimrc/ginit.vim 
mkdir -p win_vimrc/lua
cp ~/WinUser/AppData/Local/nvim/lua/* win_vimrc/lua/

difftool="vimdiff"
if command -v nvim >/dev/null 2>&1; then
  difftool="nvim -d"
fi

cat <<END >win_vimrc/diff_vimrc.sh 
#!/bin/sh

$difftool ~/.vimrc "$PWD/win_vimrc/.vimrc"
END
chmod +x win_vimrc/diff_vimrc.sh

cat <<END >win_vimrc/diff_plugin.sh 
#!/bin/sh

$difftool ~/.vimrc_plugin "$PWD/win_vimrc/.vimrc_plugin"
END
chmod +x win_vimrc/diff_plugin.sh

cat <<END >win_vimrc/diff_ginit.sh 
#!/bin/sh

$difftool ~/dotfiles/vim/symlink.ginit.vim "$PWD/win_vimrc/ginit.vim"
END
chmod +x win_vimrc/diff_ginit.sh

cat <<END >win_vimrc/summary.sh
#!/bin/bash

commCompare() {
  comm "\$1" <(sort "\$2") <(sort "\$3")
}

linesOnlyInFile1() {
  commCompare -13 "\$1" "\$2" | wc -l
}

genDiff() {
  added="\$(linesOnlyInFile1 "\$1" "\$2")"
  removed="\$(linesOnlyInFile1 "\$2" "\$1")"
  echo "\$1: +\$added -\$removed"
}
genDiff ~/.vimrc "$PWD/win_vimrc/.vimrc"
genDiff ~/.vimrc_plugin "$PWD/win_vimrc/.vimrc_plugin"
genDiff "$PWD/symlink.ginit.vim" "$PWD/win_vimrc/ginit.vim"
END
chmod +x win_vimrc/summary.sh
