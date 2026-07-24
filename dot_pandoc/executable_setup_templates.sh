#!/usr/bin/env bash


zip_file=$1

mkdir -p ~/.pandoc/templates

unzip $zip_file

pushd pandoc_typst

[[ ! -d "/usr/share/haskell=pandoc/data/templates" ]] && echo "[-] Haskell template directory does not exist...exiting" &&  exit 1

pushd pandoc
mv templates ~/.pandoc/templates
pushd pandoc

# rename typst files to typ
for i in *.typst; do mv ${i} ${i/typst/typ}; done

# fix templating errors
for i in *.typ; do ~/.pandoc/replace_template_data.sh $i; done

# move to templates directory
sudo mv *.typ  /usr/share/haskell-pandoc/data/templates

echo '[+] Successfully moved templates into templates directory in /usr/share/haskell-pandoc/data/templates'






