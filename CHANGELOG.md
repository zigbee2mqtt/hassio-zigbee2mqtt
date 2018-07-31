# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).


## [0.1.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.1) - 2018-07-29
### Changed
- Switch the edge and non-edge dockerfiles so they're actually correct. Sigh. This is why you don't write code after 28 hour shifts.
- Download release archives instead of git cloning the specific branch
- Upgrade to version 0.1.1 of `zigbee2mqtt`

## [0.1.0](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.0) - 2018-07-16
### Changed
Version 0.1.0 is the first versioned release of the add-on. The repository actually establishes two add-ons:
- `zigbee2mqtt` add-on, which will use the first released version of the `zigbee2mqtt` library and will update as new versions of that library are released
- `zigbee2mqtt-edge` add-on, which will build with the latest commit to the `zigbee2mqtt` master branch. Each update to the library will trigger a new add-on image to be built. In effect, this add-on will function the same way that the pre-release version of this add-on did.
