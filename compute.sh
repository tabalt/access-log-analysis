#!/bin/bash

################################################
# compute functions
################################################

#
# get total visit
#
function get_total_visit()
{
    log_file=$1
    total_visit=`wc -l ${log_file} | awk '{print $1}'`
    echo $total_visit
}

#
# get total bandwidth
#
function get_total_bandwidth()
{
    log_file=$1
    total_bandwidth=`awk -v total=0 '{total+=$10}END{print total/1024/1024}' ${log_file}`M
    echo $total_bandwidth
}

#
# get total unique
#
function get_total_unique()
{
    log_file=$1
    total_unique=`awk '{ip[$1]++}END{print asort(ip)}' ${log_file}`
    echo $total_unique
}

#
# get ip top N
#
function get_ip_top()
{
    log_file=$1
    top=$2
    ip_pv=`awk '{count[$1]++}END{for (ip in count){print count[ip],ip}}' ${log_file} | sort -rn | head -${top} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $ip_pv
}

#
# get url top N
#
function get_url_top()
{
    log_file=$1
    top=$2
    url_num=`awk '{count[$7]++}END{for (url in count){print count[url],url}}' ${log_file} | sort -rn | head -${top} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $url_num
}

#
# get referer top N
#
function get_referer_top()
{
    log_file=$1
    top=$2
    referer=`awk -v domain=$domain '$11 !~ /http:\/\/[^/]*'"$domain"'/{count[$11]++}END{for (url in count){print count[url],url}}' ${log_file} | sort -rn | head -${top} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $referer
}

#
# get notfound top N
#
function get_notfound_top()
{
    log_file=$1
    top=$2
    notfound=`awk '$9 == 404 {url[$7]++}END{for (k in url){print url[k],k}}' ${log_file} | sort -rn | head -${top} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $notfound
}

#
# get spider
#
function get_spider()
{
    log_file=$1
    spider=`awk -F'"' '$6 ~ /Baiduspider/ {spider["baiduspider"]++} $6 ~ /Googlebot/ {spider["googlebot"]++}END{for (k in spider){print k,spider[k]}}' ${log_file} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $spider
}

#
# get search engine
#
function get_search_enigne()
{
    log_file=$1
    search=`awk -F'"' '$4 ~ /http:\/\/www\.baidu\.com/ {search["baidu_search_enigne"]++} $4 ~ /http:\/\/www\.google\.com/ {search["google_search_enigne"]++}END{for (k in search){print k,search[k]}}' ${log_file} | awk 'BEGIN{OFS = "\\\t"; ORS = "\\\n"}{print $1,$2}'`
    echo -e $search
}

