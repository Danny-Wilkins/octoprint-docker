# octoprint-docker
A Dockerfile and process to build an Octoprint image and restore from backup, with the goal of running multiple servers from a single RPi or other device.

# Usage

1. Ensure docker is installed on device that will be running multiple Octoprint servers 
2. ```git clone https://github.com/Danny-Wilkins/octoprint-docker.git```
3. (Optional) Place an Octoprint-generated backup zip in the octoprint-docker folder and **rename it to backup.zip**. This will ensure that a working version of the server is up and ready each time a container is launched
4. ```cd octoprint-docker```
5. ```sudo docker build -t octoprint_server .```
6. Now the image is built, but we need to mount the printer USB device to the container. 
  a. Disconnect all but one printer and run ```ls /dev/serial/by-path/```
  b. The one device in there should be your printer. Copy that device name (should be like ```pci-0000:00:14.0-usb-0:8:1.0```)
  c. Create a new udev rule. ```sudo nano /etc/udev/rules.d/99-myusb.rules```, this will open a text editor. In there, place a line: ```SUBSYSTEM=="tty", ENV{ID_PATH}=="<your-device-name-(pci-xxx)>", SYMLINK +="<your-desired-device-name>"```
  d. Reboot or run ```sudo udevadm control --reload-rules && sudo udevadm trigger```
  e. Repeat for as many printers as you would like to connect
7. You're ready to run your containers! For each printer, run this command: ```sudo docker run -d -p <port>:5000 --device=/dev/<your-desired-device-name>:/dev/ttyACM0 octoprint_server```
  a. Note: Each printer needs its own <port>, I recommend starting with 8080 and going up by one for each new printer
8. Your Octoprint UIs should be accessible at <server IP>:<port>!
