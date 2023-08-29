#!/system/bin/sh

load_config() {
    MODPATH="$(dirname "$(readlink -f "$0")")"
    if [ -f "$MODPATH/config" ]; then
        . "$MODPATH/config"
    else
        PORT=""
    fi
}

enable_adb() {
    setprop service.adb.tcp.port "$PORT"
    stop adbd
    start adbd
}

(
    until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do
        sleep 5
    done

    load_config
    enable_adb
)&
