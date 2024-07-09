# Kali-VNC
a Small Kali only with vnc which you can access using VNC, **REMEMBER** to configure the dockerfile

```bash
sudo docker built -t kali-gui .
sudo docker run --rm -itd -p 9021:5900 -p 9020:8080 --device=/dev/snd:/dev/snd kali-gui
```
