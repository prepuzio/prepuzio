#!/bin/bash

TITLE=${*:-$(date +%d-%b-%y)}
set -e
TMPFILE=$(mktemp)
trap 'rm -f $TMPFILE' EXIT
sed '1{/^#/d}; 2{/^[[:space:]]*$/d}' README.md > $TMPFILE
$EDITOR $TMPFILE
{
	echo \#\#\# $TITLE
	cat $TMPFILE
} > README.md
git add README.md
git commit -m "automatic"
git push -u origin master --force # cattivo
