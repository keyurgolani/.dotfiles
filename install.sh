#################################
# Print Out Bruce Banner		#
#################################

cat Others/banner.txt
echo

#################################
# Obtain and Maintain Sudo		#
#################################

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `defaults.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#################################
# Backup Existing dotfiles		#
#################################

declare dir_backup='dotfiles_old'
declare conf_dir='confs'
declare bin_dir='bin'
declare others_dir='Others'

declare -a FILES_TO_BACKUP=(

  '$conf_dir/.bash_aliases'
  '$conf_dir/.bash_functions'
  '$conf_dir/.bash_profile'
  '$conf_dir/.bash_prompt'
  '$conf_dir/.bash_exports'
  '$conf_dir/.bashrc'
  '$conf_dir/.curlrc'
  '$conf_dir/.gitconfig'
  '$conf_dir/.inputrc'
  '$conf_dir/.screenrc'
  '$conf_dir/.wgetrc'

)

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

if ! [ -d ~/$dir_backup ]; then
	mkdir ~/$dir_backup
fi

for i in ${FILES_TO_BACKUP[@]}; do
	if [ -f ~/${i##*/} ]; then
	  echo "Moving any existing dotfiles from ~ to $dir_backup"
  	  mv ~/${i##*/} ~/$dir_backup/
	fi
done

#################################
# Install New Dotfiles    		#
#################################

for i in ${FILES_TO_BACKUP[@]}; do
	if [ -f $conf_dir/${i##*/} ]; then
	  echo "Copying any existing dotfiles from $conf_dir to ~"
  	  cp $conf_dir/${i##*/} ~/
	fi
done


#################################
# Install Binaries     			#
#################################

for bin_file in bin/*; do
	cp bin/${bin_file##*/} /usr/local/bin
	chmod +x /usr/local/bin/${bin_file##*/}
done

#################################
# Install DevTerm Theme			#
#################################

# PASS

sudo echo "#<additional-spyware-sites>" > /etc/hosts
sudo echo "0.0.0.1 spylog.com" > /etc/hosts
sudo echo "0.0.0.1 counter.spylog.com" > /etc/hosts
sudo echo "0.0.0.1 openstat.net" > /etc/hosts
sudo echo "0.0.0.1 rs.mail.ru" > /etc/hosts
sudo echo "0.0.0.1 ad.mail.ru" > /etc/hosts
sudo echo "0.0.0.1 www.roulettebotplus.com" > /etc/hosts
sudo echo "0.0.0.1 adforce.ru" > /etc/hosts
sudo echo "0.0.0.1 go.gamenet.ru" > /etc/hosts
sudo echo "0.0.0.1 www.directadvert.ru" > /etc/hosts
sudo echo "0.0.0.1 ad05f.ru" > /etc/hosts
sudo echo "0.0.0.1 mg.dt00.net" > /etc/hosts
sudo echo "0.0.0.1 zeobit.com" > /etc/hosts
sudo echo "0.0.0.1 mackeeperapp.zeobit.com" > /etc/hosts
sudo echo "#</additional-spyware-sites>" > /etc/hosts


#################################
# Install Essential Packages	#
#################################

chmod +x runnable/essential_installs.sh
runnable/essential_installs.sh

chmod +x runnable/other_installs.sh
runnable/other_installs.sh

chmod +x runnable/sublime.sh
runnable/sublime.sh

#################################
# MacOS Preferences				#
#################################

chmod +x runnable/defaults.sh
runnable/defaults.sh

#################################
# SSD Configuration				#
#################################

chmod +x runnable/ssd.sh
runnable/ssd.sh

#################################
# Atom Packages Install			#
#################################



#################################
# Cleanup Tasks					#
#################################

# Remove outdated versions from the cellar.
brew cleanup


####################################
# Kill affected applications          #
####################################

for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Google Chrome Canary" \
  "Google Chrome" \
  "Mail" \
  "Messages" \
  "Opera" \
  "Photos" \
  "Safari" \
  "SizeUp" \
  "Spectacle" \
  "SystemUIServer" \
  "Terminal" \
  "Transmission" \
  "Tweetbot" \
  "Twitter" \
  "iCal"; do
  killall "${app}" &> /dev/null
done

# Wait a bit before moving on...
sleep 1

echo "Done. Note that some of these changes require a logout/restart to take effect."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
  esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
  echo "Rebooting."
  sudo reboot
  exit 0
else
  exit 1
fi
