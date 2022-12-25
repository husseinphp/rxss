#!/bin/sh

#install subfinder
docker pull projectdiscovery/subfinder

#alias subfinder

alias subfinder='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/subfinder'

#install httpx
docker pull projectdiscovery/httpx

#install nuclei

docker pull projectdiscovery/nuclei

#alias nuclei

alias nuclei='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/nuclei'

#alias httpx

alias httpx='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/httpx'

echo "subfinder & httpx & nuclei  successfully installs "

#enumeration subdomain

subfinder -d $1 -silent >> $1subdomain.txt

wc -l <  $1subdomain.txt 

echo "enumeration subdomain  successfully  " 

httpx -l $1subdomain.txt  -o  $1live.txt

echo "enumeration httpx  successfully  " 

curl -LO https://raw.githubusercontent.com/husseinphp/hatxss/main/hatxss.yaml

echo "hatxss.yaml download successfully  " 

wc -l <  $1live.txt

#DOM-XSS-CVE-2021-24891

nuclei -list $1live.txt -t hatxss.yaml -rl 10
