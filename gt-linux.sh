#! /bin/bash

gt () {
files=("$HOME/configs")
	for file in /mnt/c/Users/user/projects/*
	do
		files+=("$file")
	done
	for file in /mnt/c/Users/user/projects/opensource/*
	do
		files+=("$file")
	done

	# for f in ${files[@]}
	# do
	# 	echo $f
	# done

	selected_file=$(printf "%s\n" "${files[@]}" | fzf)

	if [ -n "$selected_file" ]
	then
		cd "$selected_file"
	fi
}
