#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Start the nginx service
# s6-overlay docs: https://github.com/just-containers/s6-overlay
# ==============================================================================
# shellcheck disable=SC2155

set -e

z2m_config="$(bashio::config 'data_path')"

if bashio::var.is_empty "$z2m_config"; then
    bashio::log.info "data_path is unspecified. No migration necessary."

    bashio::exit.ok
fi

if bashio::var.equals "$z2m_config" "/addon_config" || bashio::var.equals "$z2m_config" "/addon_config/";then
    bashio::log.info "data_path is already '/addon_config'. No migration necessary."

    bashio::exit.ok
fi

if ! bashio::fs.directory_exists "$z2m_config"; then
    bashio::log.info "data_path '$z2m_config' does not exist. No migration necessary."

    bashio::exit.ok
fi

if [[ "$(ls -A "$z2m_config" | wc -l)" -eq 0 ]]; then
    bashio::log.info "data_path '$z2m_config' is empty. No migration necessary."

    rm -rfv "$z2m_config"
    bashio::exit.ok
fi

function archive_src() {
    tar -czvf "/addon_config/src-archive.tar.gz" "$z2m_config"
    rm -rfv "$z2m_config"
    bashio::log.info "Done archiving src."
}

bashio::log.info "Starting Zigbee2MQTT config migration..."

# don't want the symlinks if they exist, Z2M will re-create as needed so can safely delete them
rm -fv "$z2m_config/external_converters/node_modules" "$z2m_config/external_extensions/node_modules"
rm -fv "/addon_config/external_converters/node_modules" "/addon_config/external_extensions/node_modules"

if [[ $z2m_config == /addon_config/* ]]; then
    bashio::log.info "data_path is nested under addon_config folder. Skipping dst archiving..."
else
    if [[ "$(ls -A "/addon_config" | wc -l)" -ne 0 ]]; then
        bashio::log.info "New addon_config folder is not empty, archiving it..."

        # if certain files exists in addon_config, check mtime
        # check db first since it is always written on shutdown
        if bashio::fs.file_exists "/addon_config/database.db"; then
            if [[ "/addon_config/database.db" -nt "$z2m_config/database.db" ]]; then
                bashio::log.info "/addon_config/database.db is newer. Skipping migration, only archiving src..."

                archive_src
                bashio::exit.ok
            fi
        else
            # in case add-on onboarding was started but never finished, database.db does not exist
            if bashio::fs.file_exists "/addon_config/configuration.yaml" \
                && [[ "/addon_config/configuration.yaml" -nt "$z2m_config/configuration.yaml" ]]
            then
                bashio::log.info "/addon_config/configuration.yaml is newer. Skipping migration, only archiving src..."

                archive_src
                bashio::exit.ok
            fi
        fi

        tar -czvf "/addon_config.dst-archive.tar.gz" "/addon_config"

        # do not use `rm -rfv /addon_config/*` to remove content as that forces prompt with zsh
        for item in /addon_config/*; do
            rm -rfv "$item"
        done

        mv "/addon_config.dst-archive.tar.gz" "/addon_config/dst-archive.tar.gz"
        bashio::log.info "Done archiving dst."
    fi
fi

cp -R -d "$z2m_config/." "/addon_config"
bashio::log.info "Done copying src to dst."

archive_src

bashio::log.info "Successfully migrated to addon_config."
