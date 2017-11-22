#!/bin/sh

cat <<END >/tmp/basic_cpp.cpp
#include <vector>
int main() {}
END

clang -### -fsyntax-only /tmp/basic_cpp.cpp 2>&1 | \
  grep -oP '"-internal-(externc-)?isystem"\s".+?"' | \
  sed 's/"[^ ]*"/-I/' >> .clang
