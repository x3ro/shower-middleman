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

# This does a little cleaning up of the SCSS structure from the template,
# and it's not strictly required. Not prepending the SCSS files with an
# underscore will simply result in them being included in the built presentation
# too.
cd temp/styles
for file in $(ls *.scss); do
    mv $file "_$file"
done
mv "_screen.scss" "_theme.scss"
cd ../../
echo "@import 'theme';" > source/stylesheets/screen.scss

cp temp/styles/*.scss source/stylesheets/ ||
    error "Could not copy stylesheets. Expected them to be in temp/styles/"

cp temp/images/* source/images/ ||
    error "Could not copy images. Expected them to be in temp/images/"

cp -R temp/fonts source/fonts ||
    error "Could not copy fonts. Expected them to be in temp/fonts/"

rm -rf temp/ ||
    echo "Could not delete temporary directory 'temp/' :("
