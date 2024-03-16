# Home Assistant - Run multipoint Zigbee2MQTT Coordinator separately from an Official 

<<<<<<< HEAD
[![Base Image](https://img.shields.io/badge/Base%20Image-3.18-blue)](https://github.com/home-assistant/docker-base)  [![alpine-armhf](https://img.shields.io/badge/armhf-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-armv7](https://img.shields.io/badge/armv7-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-aarch64](https://img.shields.io/badge/aarch64-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-amd64](https://img.shields.io/badge/amd64-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-i386](https://img.shields.io/badge/i386-yes-brightgreen)](https://alpinelinux.org/releases/)
[![cloudflare-argo-tunnel-release](https://img.shields.io/github/v/release/racksync/hass-addons-multipoint-zigbee)](https://github.com/racksync/hass-addons-multipoint-zigbee/releases) [![last commit](https://img.shields.io/github/last-commit/racksync/hass-addons-multipoint-zigbee)](https://github.com/racksync/hass-addons-multipoint-zigbee/commit/)
=======
## Installation
1. If you don't have an MQTT broker yet; in Home Assistant go to **[Settings → Add-ons → Add-on store](https://my.home-assistant.io/redirect/supervisor_store/)** and install the **[Mosquitto broker](https://my.home-assistant.io/redirect/supervisor_addon/?addon=core_mosquitto)** addon, then start it.
1. Go back to the **Add-on store**, click **⋮ → Repositories**, fill in</br>  `https://github.com/zigbee2mqtt/hassio-zigbee2mqtt` and click **Add → Close** or click the **Add repository** button below, click **Add → Close** (You might need to enter the **internal IP address** of your Home Assistant instance first).  
[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fzigbee2mqtt%2Fhassio-zigbee2mqtt)
3. The repository includes two add-ons:
    - **Zigbee2MQTT** is the stable release that tracks the released versions of Zigbee2MQTT. (**recommended for most users**)
    - **Zigbee2MQTT Edge** tracks the `dev` branch of Zigbee2MQTT such that you can install the edge version if there are features or fixes in the Zigbee2MQTT dev branch that are not yet released.
4. Click on the addon and press **Install** and wait till the addon is installed.
5. Click on **Configuration**
    - If you are **not** using the Mosquitto broker addon fill in your MQTT details (leave empty when using the Mosquitto broker addon). Format can be found [here](https://www.zigbee2mqtt.io/guide/configuration/mqtt.html#server-connection), but skip the initial `mqtt:` indent. e.g.: <br>
        ```yaml
        server: mqtt://localhost:1883
        user: my_user
        password: "my_password"
        ```
        Note: If the `password` includes certain special characters (reserved by yaml specification), the enclosing quotes are required. So it is recommended to always quote it when in doubt.
    - Fill in the serial details (e.g. port of your USB coordinator). Format can be found [here](https://www.zigbee2mqtt.io/guide/configuration/adapter-settings.html#adapter-settings), but skip the initial `serial:` indent. e.g.: <br>
        ```yaml
        port: /dev/ttyUSB0
        ```
    - If you don't know the port and you have just one USB device connected to your machine try `/dev/ttyUSB0`. Else use the [Home Assistant CLI](https://www.home-assistant.io/common-tasks/os#home-assistant-via-the-command-line) and execute `ha hardware info` to find out. 
    - Click **Save**
    - **Tip:** it is possible to refer to variables in the Home Assistant `secrets.yaml` file (not the Zigbee2MQTT one!) by using e.g. `password: '!secret mqtt_pass'`
1. Start the addon by going to **Info** and click **Start**
1. Wait till Zigbee2MQTT starts and press **OPEN WEB UI** to verify Zigbee2MQTT started correctly.
    - If it shows `502: Bad Gateway` wait a bit more and refresh the page.
    - If this takes too long (e.g. 2 minutes +) check the **Log** tab to see what went wrong.
>>>>>>> ff786392938cebf8852e7d48bf06122518fcb3e4

## Disclaimer ###

เหมาะสำหรับท่านที่ต้องการ run zigbee2mqtt โดยสามารถแยกการทำงาน Coordinator มากกว่า 1 จุด

## How to Install Add-on

1. ติดตั้ง addon ด้วยการ add repository : https://github.com/racksync/hass-addons-multipoint-zigbee เข้าไปยัง addon list ตามปกติ
2. ตั้งค่า addon configuration ดังนี้
- serial config
```yaml
port: tcp://ip-address:6638
baudrate: 115200
disable_led: false
advanced:
  transmit_power: 20
```
<<<<<<< HEAD
- network port ที่ระบุใน addon แต่ละตัวจะต้องไม่ซ้ำกัน เช่น ZB #1 รันด้วย default :```8485``` หากต้องการรันอีกตัว (ZB #2) จะต้องแก้ไขพอร์ตไม่ให้ชนกัน เช่น ```8486``` เป็นต้น
=======
docker exec -it $(docker ps | grep zigbee2mqtt | cut -d" " -f 1) /bin/sh
```
- Edit the file you'd like to test & save. 
```
vi node_modules/zigbee-herdsman-converters/converters/toZigbee.js
```
- Back on the Home Assistant installation, restart the `zigbee2mqtt` container
```
docker restart $(docker ps | grep zigbee2mqtt | cut -d" " -f 1)
```
- Refresh the web UI and perform your testing.
>>>>>>> ff786392938cebf8852e7d48bf06122518fcb3e4

3. แก้ไข topic ในส่วนของ mqtt setting (แก้ไขผ่านหน้า zigbee config หลัก) ที่เมนู **setting -> MQTT** ตรงส่วนของ Base topic จะต้องไม่ซ้ำกัน

4. ทำการรัน Addon ทุกตัวพร้อมกันและเริ่ม Pairing ตามปกติ


### Automation Training

- [สินค้าและบริการ](http://racksync.com)
- [เทรนนิ่งคอร์ส](https://facebook.com/racksync)

### Community

- [Home Automation Thailand](https://www.facebook.com/groups/hathailand)
- [Home Automation Marketplace](https://www.facebook.com/groups/hatmarketplace)
- [Home Automation Thailand Discord](https://discord.gg/Wc5CwnWkp4) 

### [RACKSYNC CO., LTD.](https://racksync.com)

บจก.แรคซิงค์ คือผู้เชี่ยวชาญด้าน Automation และ Smart Solutions ทุกขนาด เรามีบริการให้คำปรึกษาตลอดจนวางระบบ ติดตั้งและมอนิเตอร์โดยผู้เชี่ยวชาญ นอกจากนี้เรายังเป็นบริษัทรับพัฒนา Software As A Service แบบครบวงจรอีกด้วย
\
\
RACKSYNC COMPANY LIMITED \
Suratthani, Thailand 84100 \
Email : devops@racksync.com \
Tel : +66 85 880 8885 

[![Home Automation Thailand Discord](https://img.shields.io/discord/986181205504438345?style=for-the-badge)](https://discord.gg/Wc5CwnWkp4) [![Github](https://img.shields.io/github/followers/racksync?style=for-the-badge)](https://github.com/racksync) 
[![WebsiteStatus](https://img.shields.io/website?down_color=grey&down_message=Offline&style=for-the-badge&up_color=green&up_message=Online&url=https%3A%2F%2Fracksync.com)](https://racksync.com)