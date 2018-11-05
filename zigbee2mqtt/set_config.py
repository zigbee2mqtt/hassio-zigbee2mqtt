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
        if self.options.get(option_name, None) is not None:
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

    def get_config(self, config_name, category=None):
        # return a configuraiton variable, for testing purposes.
        if category:
            return self.config.get(category).get(config_name, None)
        else:
            return self.config.get(config_name, None)

    def dump(self, config_path):
        with open(config_path, 'w') as f:
            yaml.safe_dump(self.config, f, default_flow_style=False)

    def set_log_dir(self, data_path):
        if self.options.get("log_directory", None):
            if self.config.get("advanced", None) is None:
                self.config["advanced"] = dict()
            log_dir = Path(data_path).joinpath(
                self.options.get("log_directory"))
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

    cfg = ConfigBuilder(config, options)

    cfg.set_option('homeassistant')
    cfg.set_option('permit_join')

    cfg.set_option(
        'mqtt_base_topic', category='mqtt', alt_config_name='base_topic')
    cfg.set_option('mqtt_server', category='mqtt', alt_config_name='server')
    cfg.set_option(
        'mqtt_client_id', category='mqtt', alt_config_name='client_id')
    cfg.set_option('include_device_information', category='mqtt')

    if options.get("mqtt_user", None) or options.get("mqtt_pass", None):
        cfg.set_option('mqtt_user', category='mqtt', alt_config_name='user')
        cfg.set_option(
            'mqtt_pass', category='mqtt', alt_config_name='password')

    cfg.set_option('serial_port', category='serial', alt_config_name='port')
    cfg.set_option('disable_led', category='serial')

    cfg.set_option('cache_state', category='advanced')

    cfg.set_log_dir(data_path)

    cfg.set_option('log_level', category='advanced')
    cfg.set_option('rtscts', category='advanced')
    
    cfg.set_option('soft_reset_timeout', category='advanced') 

    cfg.dump(config_path)
    print('[Info] Configuration written to {}'.format(config_path))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Construct an appropriate yaml configuration file.')
    parser.add_argument('options_path', type=str)
    parser.add_argument('data_path', type=str)
    parser.set_defaults(mqtt_user=None, mqtt_pass=None)
    args = parser.parse_args()
    main(args.options_path, args.data_path)
