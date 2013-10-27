#!/bin/bash
CURRENT_DIR=`pwd`;

if [ ! -e "${CURRENT_DIR}/install.sh" ]
then
    exit 1;
fi

function replace_file()
{
    FILE_NAME=$1;
    COPY_TO_PATH="${HOME}/.${FILE_NAME}";
    COPY_FROM_PATH="${CURRENT_DIR}/${FILE_NAME}";
    BACKUP_PATH="${HOME}/${FILE_NAME}.old";

    echo "copy ${COPY_TO_PATH}";

    if [ ! -e $COPY_FROM_PATH ]
    then
        echo "    \_ fatal: file does not exists, ${COPY_FROM_PATH}";
        return -1;
    fi

    if [ -e $COPY_TO_PATH ]
    then
        echo "    \_ warning: file exist, ${COPY_TO_PATH}";
        echo "        \_ [copy] ${COPY_TO_PATH} to ${BACKUP_PATH}";
        cp $COPY_TO_PATH $BACKUP_PATH;
    fi

    cp $COPY_FROM_PATH $COPY_TO_PATH;
    echo "    \_ succeed";
    return 0;
}

function copy_alias()
{
    COPY_TO_PATH="${HOME}/.bash";
    COPY_FROM_PATH="${CURRENT_DIR}/bash";
    BACKUP_PATH="${HOME}/bash.old";

    echo "copy bash alias";

    if [ ! -e $COPY_FROM_PATH ]
    then
        echo "    \_ fatal: file does not exists, ${COPY_FROM_PATH}";
        return -1;
    fi


    if [ -e $COPY_TO_PATH ]
    then
        echo "    \_ warning: file exists, ${COPY_TO_PATH}";
        echo "        \_ [copy] ${COPY_TO_PATH} to ${BACKUP_PATH}";
        mv $COPY_TO_PATH $BACKUP_PATH;
    fi

    cp -r $COPY_FROM_PATH $COPY_TO_PATH;
    echo "    \_ succeed";
    return 0;
}

function copy_mylisp()
{
    COPY_TO_PATH="${HOME}/.mylisp";
    COPY_FROM_PATH="${CURRENT_DIR}/mylisp";
    BACKUP_PATH="${HOME}/mylisp.old";

    echo "copy mylisp";

    if [ ! -e "${CURRENT_DIR}/mylisp.tgz" ]
    then
        echo "    \_ fatal: file does not exists, ${CURRENT_DIR}/mylisp.tgz";
        return -1;
    fi

    tar xzf "${CURRENT_DIR}/mylisp.tgz";

    if [ -e $COPY_TO_PATH ]
    then
        echo "    \_ warning: file exists, ${COPY_TO_PATH}";
        echo "        \_ [copy] ${COPY_TO_PATH} to ${BACKUP_PATH}";
        mv $COPY_TO_PATH $BACKUP_PATH;
    fi

    mv $COPY_FROM_PATH $COPY_TO_PATH;
    echo "    \_ succeed";
    return 0;
}


replace_file "bash_profile";
replace_file "bashrc";
replace_file "dir_colors";
replace_file "emacs";
replace_file "gitconfig";
replace_file "inputrc";
replace_file "screenrc";
replace_file "git-completion.bash";
copy_alias;
copy_mylisp;

sudo apt-get update; sudo apt-get install screen tree lv emacs;
