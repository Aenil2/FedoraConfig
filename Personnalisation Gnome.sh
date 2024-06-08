# Personnalisation Gnome
echo -e "Configuration de l'interface"
echo -e "\n- Date et heure"
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
echo -e "\n- Thème"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
echo -e "\n- Batterie"
gsettings set org.gnome.desktop.interface show-battery-percentage true
echo -e "\n- Accélération de la souris"
gsettings set org.gnome.desktop.peripherals.mouse  accel-profile adaptive
echo -e "\n- Suramplification"
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
echo -e "\n- Boutons de fenêtre"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,spacer,close
echo -e "\n- Désactivation des sons système"
gsettings set org.gnome.desktop.wm.preferences audible-bell false
echo -e "\n- Purge des fichiers de plus de 15 jours"
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy old-files-age 15

echo -e "Confidentialité"
echo -e "\n- Désactivation des rapports"
gsettings set org.gnome.desktop.privacy report-technical-problems false
echo -e "\n- Désactivation des statistiques d'utilisation"
gsettings set org.gnome.desktop.privacy send-software-usage-stats false

echo -e "Nautilus"
echo -e "\n- Affichage des fichiers/dossiers cachés"
gsettings set org.gnome.nautilus.preferences show-hidden-files true
echo -e "\n- Suppression définitive"
gsettings set org.gnome.nautilus.preferences show-delete-permanently true

echo -e "Gnome Logiciels"
echo -e "\n- Désactivation du téléchargement des mises à jour automatique"
gsettings set org.gnome.software download-updates false
echo -e "\n- Logiciels propriétaires"
gsettings set org.gnome.software prompt-for-nonfree false

echo -e "Gnome Text Editor"
echo -e "\n- Grille"
gsettings set org.gnome.TextEditor show-grid true
echo -e "\n- Auto-indentation"
gsettings set org.gnome.TextEditor auto-indent true

# Config DNF
echo -e "Configuration DNF"
echo -e "\nfastestmirror=true" >> /etc/dnf/dnf.conf
echo -e "\ndefaultyes=true" >> /etc/dnf/dnf.conf
echo -e "\nmax_parallel_downloads=10" >> /etc/dnf/dnf.conf
dnf check-update --refresh fedora-release > /dev/null 2>&1

# Purge des logiciels
echo -e "\nDésinstallation du bloatware"
dnf remove -y libreoffice-* gnome-boxes gnome-calendar gnome-clocks gnome-contacts yelp gnome-maps baobab gnome-connections gnome-disks gnome-weather

# Flathub
echo -e "\n- Installation Flathub : "
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo > /dev/null

# RPM Fusion + Codecs 
echo -e "\n- Installation de RPM"
dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data && sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
echo "\n- Installation des codecs"
dnf install -y gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-bad-free gstreamer1-plugins-good-extras gstreamer1-plugins-bad-free-extras gstreamer1-plugins-ugly-free gstreamer1-plugin-libav gstreamer1-plugins-ugly libdvdcss gstreamer1-plugin-openh264 ffmpeg

# FFMPEG
echo "\nSwapping de FFMPEG"
if rpm -q "\nffmpeg-free" > /dev/null
then
    dnf swap -y "\nffmpeg-free" "ffmpeg" --allowerasing > /dev/null 2>&1
fi

# Flatpaks
echo -e "\nInstallation des flatpaks"
flatpak install -y flathub com.toolstack.Folio
flatpak install -y flathub re.sonny.Junction
flatpak install -y flathub net.ankiweb.Anki
flatpak install -y flathub com.visualstudio.code
flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub com.protonvpn.www
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.github.xournalpp.xournalpp
flatpak install -y flathub re.sonny.Workbench
flatpak install -y flathub io.missioncenter.MissionCenter
flatpak install -y flathub app.devsuite.Ptyxis
