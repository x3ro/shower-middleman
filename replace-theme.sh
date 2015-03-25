#!/bin/bash -x

function error {
    echo "Error: $1"
    rm -rf temp/ ||
        echo "Could not delete temporary directory 'temp/' :("
    exit 1
}

(( $# == 1 )) ||
    error "Please provide a git URL of a Shower theme as the only parameter"

[[ -d "source" && -d "source/stylesheets" && -d "source/javascripts" ]] ||
    error "Please run this command from the root of 'shower-middleman"

git clone $1 temp/ ||
    error "Could not clone '$1' to temp"

cp temp/styles/*.scss source/stylesheets/ ||
    error "Could not copy stylesheets. Expected them to be in temp/styles/"

cp temp/images/* source/images/ ||
    error "Could not copy images. Expected them to be in temp/images/"

cp -R temp/fonts source/fonts ||
    error "Could not copy fonts. Expected them to be in temp/fonts/"

rm -rf temp/ ||
    echo "Could not delete temporary directory 'temp/' :("
