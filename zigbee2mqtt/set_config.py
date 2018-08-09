import json
import argparse
from pathlib import Path
import yaml


def main(options_path, data_path):

    config = dict()
    config_path = Path(data_path).joinpath('configuration.yaml')
    if config_path.is_file():  # check if config file exists in data path
        print("[Info] Configuration file found. Will overwrite configurable \
              fields with values from add-on configuration")
        with open(config_path) as f:
            config = yaml.safe_load(f)
    else:  # make sure the data_path folder exists; if not, create it
        if not Path(data_path).is_dir():
            Path(data_path).mkdir()

    with open(options_path) as f:
        options = json.load(f)

    config['homeassistant'] = options["homeassistant"]
    config['permit_join'] = options["permit_join"]
    if config.get('mqtt', None) is None:
        config['mqtt'] = dict()
    config['mqtt']['base_topic'] = options["mqtt_base_topic"]
    config['mqtt']['server'] = options["mqtt_server"]

    if options.get("mqtt_user", None) or options.get("mqtt_pass", None):
        config['mqtt']['user'] = options["mqtt_user"]
        config['mqtt']['password'] = options["mqtt_pass"]

    if config.get('serial', None) is None:
        config['serial'] = dict()
    config['serial']['port'] = options["serial_port"]
    if options.get("serial_disable_led", None):
        config['serial']['disable_led'] = options["serial_disable_led"]

    with open(config_path, 'w') as f:
        yaml.safe_dump(config, f, default_flow_style=False)

    print('[Info] Configuration written to {}'.format(config_path))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Construct an appropriate yaml configuration file.')
    parser.add_argument('options_path', type=str)
    parser.add_argument('data_path', type=str)
    parser.set_defaults(mqtt_user=None, mqtt_pass=None)
    args = parser.parse_args()
    main(args.options_path, args.data_path)
