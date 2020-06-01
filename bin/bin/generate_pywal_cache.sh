#!/bin/sh

for backend in wal haishoku colorthief
do
    wal -i $1 --backend $backend;
done
