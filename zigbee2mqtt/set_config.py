import json
import argparse
from pathlib import Path
import yaml


class ConfigBuilder:
    def __init__(self, config, options):
        self.config = config
        self.options = options

    def set_option(self, option_name, category=None, alt_config_name=None):
        # some options are optional, skip them if it's not set
        if self.options.get(option_name, None):
            if category:
                if self.config.get(category, None) is None:
                    self.config[category] = dict()
                if alt_config_name is None:
                    self.config[category][option_name] = self.options[
                        option_name]
                else:
                    self.config[category][alt_config_name] = self.options[
                        option_name]
            else:
                if alt_config_name is None:
                    self.config[option_name] = self.options[option_name]
                else:
                    self.config[alt_config_name] = self.options[option_name]

    def get_option(self, option_name, category=None):
        if category:
            return self.options.get(category).get(option_name, None)
        else:
            return self.options.get(option_name, None)

    def dump(self, config_path):
        with open(config_path, 'w') as f:
            yaml.safe_dump(self.config, f, default_flow_style=False)

    def set_log_dir(self, data_path):
        log_dir = Path(data_path).joinpath(self.options["log_directory"])
        self.config["advanced"]["log_directory"] = log_dir


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

    config = ConfigBuilder(config, options)

    config.set_option('homeassistant')
    config.set_option('permit_join')

    config.set_option(
        'mqtt_base_topic', category='mqtt', alt_config_name='base_topic')
    config.set_option('mqtt_server', category='mqtt', alt_config_name='server')
    config.set_option(
        'mqtt_client_id', category='mqtt', alt_config_name='client_id')

    if options.get("mqtt_user", None) or options.get("mqtt_pass", None):
        config.set_option('mqtt_user', category='mqtt', alt_config_name='user')
        config.set_option(
            'mqtt_pass', category='mqtt', alt_config_name='password')

    config.set_option('serial_port', category='serial', alt_config_name='port')
    config.set_option('disable_led', category='serial')

    config.set_option('cache_state', category='advanced')
    config.set_log_dir(data_path, options['log_directory'])
    config.set_option('log_directory', category='advanced')
    config.set_option('log_level', category='advanced')
    config.set_option('rtscts', category='advanced')

    config.dump(config_path)
    print('[Info] Configuration written to {}'.format(config_path))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Construct an appropriate yaml configuration file.')
    parser.add_argument('options_path', type=str)
    parser.add_argument('data_path', type=str)
    parser.set_defaults(mqtt_user=None, mqtt_pass=None)
    args = parser.parse_args()
    main(args.options_path, args.data_path)
