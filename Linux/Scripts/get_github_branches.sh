#!/bin/bash

#cd ~/github/
# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

for dir in $1/* #~/github/*
do
	test -d "$dir" || continue
	# Do something with $dir...
	cd $dir
	echo -n $dir
	echo -n " --->"
	parse_git_branch
	echo -e "\n"
done
