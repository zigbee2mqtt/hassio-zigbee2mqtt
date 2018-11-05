import json
import yaml
from pathlib import Path

TEST_JSON = '''
{
  "data_path": "/share/zigbee2mqtt",
  "homeassistant": true,
  "permit_join": true,
  "mqtt_base_topic": "zigbee2mqtt",
  "mqtt_server": "mqtt://localhost",
  "mqtt_client_id": "test",
  "serial_port": "/dev/ttyACM0",
  "disable_led": true,
  "mqtt_user": "username",
  "mqtt_pass": "secret",
  "log_level": "debug",
  "log_directory": "logs/",
  "rtscts": false,
  "cache_state": true
}
'''


def test_write_config():
    config = {}
    options = json.loads(TEST_JSON)

    config_path = Path('./test_config.yaml')

    config['homeassistant'] = options["homeassistant"]
    config['permit_join'] = options["permit_join"]
    if config.get('mqtt', None) is None:
        config['mqtt'] = dict()
    config['mqtt']['base_topic'] = options["mqtt_base_topic"]
    config['mqtt']['server'] = options["mqtt_server"]
    config['serial'] = {}
    config['serial']['port'] = options["serial_port"]

    with open(config_path, 'w') as f:
        yaml.safe_dump(config, f)
    with open(config_path) as f:
        config = yaml.safe_load(f)

    assert config['homeassistant'] is True
    assert config['mqtt']['base_topic'] == "zigbee2mqtt"

    # clean up
    if config_path.is_file():
        config_path.unlink()


def test_config_build_end_to_end():
    from set_config import ConfigBuilder
    options = json.loads(TEST_JSON)
    config = {}
    cfg = ConfigBuilder(config, options)
    data_path = "/share/zigbee2mqtt"

    cfg.set_option('homeassistant')
    cfg.set_option('permit_join')
    cfg.set_option(
        'mqtt_base_topic', category='mqtt', alt_config_name='base_topic')
    cfg.set_option('mqtt_server', category='mqtt', alt_config_name='server')
    cfg.set_option(
        'mqtt_client_id', category='mqtt', alt_config_name='client_id')
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

    print(config)

    assert cfg.get_config('homeassistant') is True
    assert cfg.get_config('permit_join') is True
    assert cfg.get_config('base_topic', category='mqtt') == "zigbee2mqtt"
    assert cfg.get_config('server', category='mqtt') == "mqtt://localhost"
    assert cfg.get_config('client_id', category='mqtt') == "test"
    assert cfg.get_config('user', category='mqtt') == "username"
    assert cfg.get_config('password', category='mqtt') == "secret"
    assert cfg.get_config('port', category='serial') == "/dev/ttyACM0"
    assert cfg.get_config('disable_led', category='serial') is True
    assert cfg.get_config('log_level', category='advanced') == "debug"
    assert cfg.get_config(
        'log_directory',
        category='advanced') == Path("/share/zigbee2mqtt/logs/")
    assert cfg.get_config('rtscts', category='advanced') is False
    assert cfg.get_config('cache_state', category='advanced') is True


def test_read_hassio_options():
    options_path = Path('./zigbee2mqtt/test_hassio_options.json')
    with open(options_path) as f:
        options = json.load(f)

    assert options['homeassistant'] is True


def test_yaml_block_style():
    document = """a: 1\nb:\n  c: 3\n  d: 4\n"""
    block_style_yaml = yaml.safe_dump(
        yaml.load(document), default_flow_style=False)
    print(document)
    print(block_style_yaml)
    assert block_style_yaml == document


def test_config_builder():
    from set_config import ConfigBuilder
    options_path = Path('./zigbee2mqtt/test_hassio_options.json')
    with open(options_path) as f:
        options = json.load(f)

    cfg = ConfigBuilder({}, options)
    cfg.set_option('log_level', category='advanced')
    config_path = Path('./test_config.yaml')
    cfg.dump(config_path)
    with open(config_path) as f:
        test_config = yaml.safe_load(f)

    assert test_config['advanced']['log_level'] == "debug"

    # clean up
    if config_path.is_file():
        config_path.unlink()


def test_config_set_log_dir():
    from set_config import ConfigBuilder
    config = {}
    options = json.loads(TEST_JSON)
    cfg = ConfigBuilder(config, options)
    cfg.set_log_dir("/share/zigbee2mqtt")
    assert cfg.get_config(
        "log_directory",
        category="advanced") == Path("/share/zigbee2mqtt/logs/")
