#! /usr/bin/env bash

current_song() {
    echo "$(sp current | grep -v Album)" | awk '
    /^Artist / {
        artist = gensub(/^Artist\s+/, "", "g")
        printf "%s  ^fg(\#009688)^fn(FontAwesome:size=13)^fn()^fg()  ", artist
    }

    /^Title / {
        title = gensub(/^Title\s+/, "", "g")
        print title
    }
    '
}


while :; do
    echo "$(current_song)"
    sleep 3
done | dzen2 -x '710' -y '0' -h '25' -w '500' -ta 'c' -fg '#cfd8dc' -bg '#212121' -fn 'Iosevka' -dock

