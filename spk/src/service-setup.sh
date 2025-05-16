
MIHOMO="${SYNOPKG_PKGDEST}/usr/local/bin/mihomo"
SVC_BACKGROUND=true
SVC_WRITE_PID=true

SERVICE_COMMAND="${MIHOMO} -d ${SYNOPKG_PKGVAR}"

service_postinst ()
{
    CONFIG_FILE="${SYNOPKG_PKGVAR}/config.yaml"
    if [ ! -e ${CONFIG_FILE} ]; then
        CONFIG_TEMPLATE="${SYNOPKG_PKGDEST}/usr/local/etc/config.yaml"
        if [ -e ${CONFIG_TEMPLATE} ]; then
            install -m 644 ${CONFIG_TEMPLATE} ${CONFIG_FILE}
        fi
    fi
}
