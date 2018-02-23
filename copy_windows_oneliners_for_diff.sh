#!/bin/sh

mkdir -p win_oneliners

cp ~/WinUser/oneliners win_oneliners/oneliners

cat <<END >win_oneliners/diff_oneliners.sh 
#!/bin/sh

vimdiff "$PWD/oneliners" "$PWD/win_oneliners/oneliners"
END
chmod +x win_oneliners/diff_oneliners.sh

cat <<END >win_oneliners/summary.sh
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
genDiff "$PWD/oneliners" "$PWD/win_oneliners/oneliners"
END
chmod +x win_oneliners/summary.sh
