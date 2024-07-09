FROM kalilinux/kali-rolling:latest 

ARG KALI_VERSION=headless
ENV DEBIAN_FRONTEND=nointeractive 
RUN apt update 
RUN apt upgrade -y 
RUN apt install -y kali-linux-${KALI_VERSION}
RUN apt install -y dbus dbus-x11 novnc net-tools nano tightvncserver net-tools htop pulseaudio autocutsel inetutils-ping
RUN apt clean 

ARG KALI_GUI=xfce
RUN apt install -y kali-desktop-${KALI_GUI}
RUN apt remove -y xfce4-power-manager 
RUN apt clean
ENV USER=root 


ENV userKali=default 
ENV passKali=default
RUN useradd -rm -d /home/h4des -s /bin/zsh -g root -G sudo -u 1001 h4des
RUN echo '${userKali}:${passKali}' | chpasswd 
RUN apt clean 
RUN apt autoremove -y
WORKDIR /home/h4des

ENV VNCEXPOSE= 
ENV VNCPORT=
ENV VNCPWD=
ENV VNCDISPLAY=
ENV VNCDEPTH=

COPY config.sh /config.sh 
RUN chmod 755 /config.sh 
ENTRYPOINT [ "/config.sh" ]
