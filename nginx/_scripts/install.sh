#!/bin/bash
echo "[-][Nginx] Begin installation ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")

#add autocompletion
if ! pacman -Qi nginx; then
    echo "Install nginx";
    sudo pacman -S nginx;
    echo "Create sites directory";
    sudo mkdir -p /etc/nginx/sites-available;
    sudo mkdir -p /etc/nginx/sites-enabled;

    if grep -q "include /etc/nginx/sites-enabled/\*" /etc/nginx/nginx.conf ; then
        echo "include /etc/nginx/sites-enabled already included";
    else
        sed -i 's/# another virtual host/include \/etc\/nginx\/sites-enabled\/*;\n    # another virtual host/' /etc/nginx/nginx.conf;
    fi
fi

if [ -f /etc/hosts ];then
    echo "Backup hosts ~/hosts.$DATE.bak";
    sudo cp /etc/hosts ~/hosts.$DATE.bak;
fi

echo "Backup nginx current in sites ~/vhosts.$DATE/";
mkdir ~/vhosts.$DATE;
sudo cp /etc/nginx/sites-available/* ~/vhosts.$DATE/;

for vhost in `find "$(pwd)/sites-available/" -type f -printf "%f\n" && find "$(pwd)/sites-available/" -type l -printf "%f\n"`; do
    echo "";
    echo "Find vhost: $vhost";
    read -r -p "Add to nginx sites? [Y/n]" response;
    response=${response,,} # tolower
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        sudo ln -fs "$(pwd)/sites-available/$vhost" /etc/nginx/sites-available/;
    fi
    read -r -p "Enable vhost? [Y/n]" response;
    response=${response,,} # tolower
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        sudo ln -fs /etc/nginx/sites-available/$vhost /etc/nginx/sites-enabled/$vhost;
        if grep -q "$vhost" /etc/hosts ; then
            echo "$vhost already exists in /etc/hosts, resolve conflict manually";
            grep $vhost /etc/hosts;
        else
            line="127.0.0.1    $vhost";
            echo "Add $line to /etc/hosts";
            echo $line | sudo tee -a /etc/hosts;
            cat /etc/hosts;
        fi
    else
        echo "You must symlink sites-available and update /etc/hosts to enable"
    fi
done

echo "Nginx sites enabled:";
ls -al /etc/nginx/sites-enabled/;
echo "HOSTS NOW:";
sudo cat /etc/hosts;

sudo systemctl restart nginx;
echo "[+][Nginx] installation complete.";
