# Home Assistant - Run multipoint Zigbee2MQTT Coordinator separately from an Official 

[![Base Image](https://img.shields.io/badge/Base%20Image-3.18-blue)](https://github.com/home-assistant/docker-base)  [![alpine-armhf](https://img.shields.io/badge/armhf-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-armv7](https://img.shields.io/badge/armv7-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-aarch64](https://img.shields.io/badge/aarch64-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-amd64](https://img.shields.io/badge/amd64-yes-brightgreen)](https://alpinelinux.org/releases/) 
[![alpine-i386](https://img.shields.io/badge/i386-yes-brightgreen)](https://alpinelinux.org/releases/)
[![cloudflare-argo-tunnel-release](https://img.shields.io/github/v/release/racksync/hass-addons-multipoint-zigbee)](https://github.com/racksync/hass-addons-multipoint-zigbee/releases) [![last commit](https://img.shields.io/github/last-commit/racksync/hass-addons-multipoint-zigbee)](https://github.com/racksync/hass-addons-multipoint-zigbee/commit/)

## Disclaimer ###

เหมาะสำหรับท่านที่ต้องการ run zigbee2mqtt โดยสามารถแยกการทำงาน Coordinator มากกว่า 1 จุดขึ้นไปได้อย่างอิสระ

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
- network port ที่ระบุใน addon แต่ละตัวจะต้องไม่ซ้ำกัน เช่น ZB #1 รันด้วย default :```8485``` หากต้องการรันอีกตัว (ZB #2) จะต้องแก้ไขพอร์ตไม่ให้ชนกัน เช่น ```8486``` เป็นต้น

3. แก้ไข topic ในส่วนของ mqtt setting (แก้ไขผ่านหน้า zigbee config หลัก) ที่เมนู **setting -> MQTT** ตรงส่วนของ Base topic จะต้องไม่ซ้ำกัน

4. ทำการรัน Addon ทุกตัวพร้อมกันและเริ่ม Pairing ตามปกติ


### Automation Training

- [สินค้าและบริการ](http://racksync.com)
- [เทรนนิ่งคอร์ส](https://facebook.com/racksync)

### Community

- [Home Automation Thailand](https://www.facebook.com/groups/hathailand)
- [Home Automation Marketplace](https://www.facebook.com/groups/hatmarketplace)
- [Home Automation Thailand Discord](https://discord.gg/Wc5CwnWkp4) 

## [RACKSYNC CO., LTD.](https://racksync.com)

บจก.แรคซิงค์ คือผู้เชี่ยวชาญด้าน Automation และ Smart Solutions ทุกขนาด เรามีบริการให้คำปรึกษาตลอดจนวางระบบ ติดตั้งและมอนิเตอร์โดยผู้เชี่ยวชาญ นอกจากนี้เรายังเป็นบริษัทรับพัฒนา Software As A Service แบบครบวงจรอีกด้วย
\
\
RACKSYNC COMPANY LIMITED \
Suratthani, Thailand 84100 \
Email : devops@racksync.com \
Tel : +66 85 880 8885 

[![Home Automation Thailand Discord](https://img.shields.io/discord/986181205504438345?style=for-the-badge)](https://discord.gg/Wc5CwnWkp4) [![Github](https://img.shields.io/github/followers/racksync?style=for-the-badge)](https://github.com/racksync) 
[![WebsiteStatus](https://img.shields.io/website?down_color=grey&down_message=Offline&style=for-the-badge&up_color=green&up_message=Online&url=https%3A%2F%2Fracksync.com)](https://racksync.com)