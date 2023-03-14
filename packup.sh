#!/bin/sh
#============ get the folder name ===========
for d in */; do
  echo $d
  echo ${d%/*}
  7z a -y "${d%/*}.7z" "$d"
  rm -rf "$d"
done
