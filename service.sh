#!/system/bin/sh

load_config() {
    if [ -f "$MODPATH/config" ]; then
        . "$MODPATH/config"
    else
        PORT=-1
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
