#!/bin/bash

# require $HOME to be set
if [ -z $HOME ]; then
	echo "\$HOME not set. Bailing." >&2
	exit 1
fi

# always execute from inside of script's directory
cd $(dirname $0)

# option defaults
forceln=""
verbose="no"

# options processing
while getopts ":fv" optname; do
	case $optname in
		f)
			forceln="-f"
			;;
		v)
			verbose="yes"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

lndir=$(pwd | sed -e 's?'$HOME'/??')

for f in .[a-zA-Z0-9]*; do
	case $f in
		.gitignore|.gitmodules|.git)
			;;
		*)
			[ $verbose == "yes" ] && echo "Linking $HOME/$f to $lndir/$f..."
			ln -ns $forceln "$lndir/$f" "$HOME"
			;;
	esac
done

exit 0
