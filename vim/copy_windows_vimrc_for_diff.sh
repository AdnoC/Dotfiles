#!/bin/sh

mkdir -p win_vimrc

cp ~/WinUser/AppData/Local/nvim/init.vim win_vimrc/.vimrc
cp ~/WinUser/AppData/Local/nvim/.vimrc_plugin win_vimrc/.vimrc_plugin

cat <<END >win_vimrc/diff_vimrc.sh 
#!/bin/sh

vimdiff ~/.vimrc $PWD/win_vimrc/.vimrc
END
chmod +x win_vimrc/diff_vimrc.sh

cat <<END >win_vimrc/diff_plugin.sh 
#!/bin/sh

vimdiff ~/.vimrc_plugin $PWD/win_vimrc/.vimrc_plugin
END
chmod +x win_vimrc/diff_plugin.sh
