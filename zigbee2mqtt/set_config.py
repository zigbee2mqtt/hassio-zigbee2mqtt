import json
import argparse
from pathlib import Path
import yaml


def main(options_path, data_path):

    config = {}
    config_path = Path(data_path).joinpath('configuration.yaml')
    if config_path.is_file():
        print("[Info] Configuration file found. Will overwrite configurable \
              fields with values from add-on configuration")
        with open(config_path) as f:
            config = yaml.safe_load(f)

    with open(options_path) as f:
        options = json.load(f)

    config['homeassistant'] = options["homeassistant"]
    config['permit_join'] = options["permit_join"]
    config['mqtt']['base_topic'] = options["mqtt_base_topic"]
    config['mqtt']['server'] = options["mqtt_server"]
    if options["mqtt_user"] or options["mqtt_pass"]:
        config['mqtt']['user'] = options["mqtt_user"]
        config['mqtt']['password'] = options["mqtt_pass"]
    config['serial']['port'] = options["serial_port"]

    with open('/app/data/configuration.yaml', 'w') as f:
        yaml.safe_dump(config, f)

    print('[Info] Configuration written to {}'.format(config_path))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Construct an appropriate yaml configuration file.')
    parser.add_argument(
        '--options_path', dest='options_path', type=str, required=True)
    parser.add_argument(
        '--data_path', dest='data_path', type=str, required=True)
    parser.set_defaults(mqtt_user=None, mqtt_pass=None)
    args = parser.parse_args()
    main(args.options_path, args.data_path)
