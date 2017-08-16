mkdir -p ~/.subl/User
cp -r ../confs/.subl/User ~/.subl/
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/.subl/User
