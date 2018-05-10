import argparse
import yaml


def main(homeassistant,
         permit_join,
         mqtt_base_topic,
         mqtt_server,
         serial_port,
         mqtt_user=None,
         mqtt_pass=None):

    with open('/app/data/configuration.yaml') as f:
        config = yaml.safe_load(f)

    config['homeassistant'] = homeassistant
    config['permit_join'] = permit_join
    config['mqtt']['base_topic'] = mqtt_base_topic
    config['mqtt']['server'] = mqtt_server
    if mqtt_user or mqtt_pass:
        config['mqtt']['user'] = mqtt_user
        config['mqtt']['password'] = mqtt_pass
    config['serial']['port'] = serial_port

    with open('/app/data/configuration.yaml', 'w') as f:
        yaml.safe_dump(config, f)

    print('[Info] Configuration written to /app/adata/configuration.yaml:')
    print(yaml.safe_dump(config))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Construct an appropriate yaml configuration file.')
    parser.add_argument(
        '--homeassistant', dest='homeassistant', type=bool, required=True)
    parser.add_argument(
        '--permit_join', dest='permit_join', type=bool, required=True)
    parser.add_argument(
        '--mqtt_base_topic', dest='mqtt_base_topic', type=str, required=True)
    parser.add_argument(
        '--mqtt_server', dest='mqtt_server', type=str, required=True)
    parser.add_argument(
        '--serial_port', dest='serial_port', type=str, required=True)
    parser.add_argument(
        '--mqtt_user', dest='mqtt_user', type=str, required=False)
    parser.add_argument(
        '--mqtt_pass', dest='mqtt_pass', type=str, required=False)
    parser.set_defaults(mqtt_user=None, mqtt_pass=None)
    args = parser.parse_args()
    main(args.homeassistant, args.permit_join, args.mqtt_base_topic,
         args.mqtt_server, args.serial_port)
