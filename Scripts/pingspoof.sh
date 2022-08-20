#!/bin/bash
tc qdisc add dev wlan0 root netem delay $1ms
