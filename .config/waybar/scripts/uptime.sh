#!/bin/sh

awk '{
    s=int($1)
    yr=int(s/31536000); s%=31536000
    mn=int(s/2592000);  s%=2592000
    d=int(s/86400);     s%=86400
    hr=int(s/3600)
    m=int((s%3600)/60)

    if(yr) printf "%dyr ",yr
    if(mn) printf "%dmn ",mn
    if(d)  printf "%dd ",d
    if(hr) printf "%dhr ",hr
    printf "%dm\n",m
}' /proc/uptime
