#!/bin/bash

# relink target-file source-file
relink() {
    if [[ -h "$1" ]]; then
        echo "Relinking $1"
        # Symbolic link? Then recreate.
        rm "$1"
        ln -sn "$2" "$1"
    elif [[ ! -e "$1" ]]; then
        echo "Linking $1 to $2"
        ln -sn "$2" "$1"
    else
        echo "$1 exists as a real file, skipping."
    fi
}

DIR=$( cd "$( dirname "$0" )" && pwd )

relink ~/.bash_profile $DIR/bash_profile
relink ~/.bashrc       $DIR/bashrc
relink ~/.dir_colors   $DIR/dir_colors
relink ~/.gitconfig    $DIR/git-config
relink ~/.inputrc      $DIR/inputrc
relink ~/.screenrc     $DIR/screenrc
relink ~/.emacs.d      $DIR/emacs.d

if [ `uname` == "Darwin" ]; then
    echo -e "\nINSTALL homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    while read line; do
        result=`echo ${line} | tr -d "\r" | tr -d "\n"`

        if [ `echo ${result} | egrep "^#" | wc -l` -gt 0 ] || [ "${result}" == "" ]; then
            continue
        fi

        if [[ ${result} =~ ^appstore  ]]; then
            app_name=`echo ${result} | awk '{print $2}'`
            echo -e "\033[4;31mNotice\033[0;39m: Plz install \033[4;39m${app_name}\033[0;39m for AppStore"
        else
            echo "BREW exec ${line}"
            brew ${line}
            echo ""
        fi
    done < Brewfile
fi
