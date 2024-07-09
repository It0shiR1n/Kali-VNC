#!/bin/bash

YOUR_USER="user"
YOUR_PASS="user"

# Creating vnc directory for root
mkdir -p /root/.vnc
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd 

# Creating vnc directory for common user
su $YOUR_USER -c "mkdir -p /home/$YOUR_USER/.vnc/"
su $YOUR_USER -c "echo $VNCPWD | vncpasswd -f > /home/$YOUR_USER/.vnc/passwd"
su $YOUR_USER -c "chmod 600 /home/$YOUR_USER/.vnc/passwd"

# Configuring autocutsel, vnc database and fixing the X keyboard 
echo '#!/bin/bash
autocutsel -fork 
xrdb "$HOME/.Xresources"
xsetroot -solid grey 
export XKL_XMODMAP_DISABLE=1
etc/X11/Xsession' > /home/$YOUR_USER/.vnc/tightvncserver.conf

chmod 777 /home/$YOUR_USER/.vnc/tightvncserver.conf

# Starting VNC
su $YOUR_USER -c "vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH > /dev/null 2>&1 &"

/bin/bash && su - $YOUR_USER
