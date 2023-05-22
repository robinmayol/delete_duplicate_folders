#! /bin/bash

if [ "$1" == "" ]; then
    echo "Please specify a directory to compare the current one against."
    echo "e.g: delete_duplicate_folders.sh ../poo/"
else
    echo
    echo "This script will look for files or folders that share the same name in two directories and delete the matching ones from the current directory"
    echo "Current directory (in which items will be DELETED): $(pwd)"
    echo "Compare directory (untouched): $1"

    echo

    for file in ./*
        do
            file_name=$(basename "$file")
            echo "looking for $file_name..."
            for fileprime in $1*
                do
                    fileprime_name=$(basename "$fileprime")

                    if [ "$file_name" == "$fileprime_name" ]; then
                        echo "  $file matches $fileprime"
                        read -p "  delete $file? (y)es/(n)o/(t)rash: " answer
                        if [ "$answer" == "y" ]; then
                            echo "    deleting $file..."
                            rm -rfv "$file"
                        elif [ "$answer" == "t" ]; then
                            echo "    trashing $file..."
                            gio trash "$file"
                        else
                            echo "    fine. moving on..."
                        fi
                    fi
                done
        done
fi
