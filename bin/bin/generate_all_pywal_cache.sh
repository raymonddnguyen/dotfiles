#!/bin/sh

for wallpaper in ~/workspace/wallpapers/*
do
    for backend in wal haishoku colorthief
    do
        status=$?;
        [ $status -eq 0 ] && wal -sten -i $wallpaper --backend $backend;
    done
done
