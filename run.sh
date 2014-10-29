#!/bin/bash

#
# get dir and report type
#

this_file=`pwd`"/"$0
this_dir=`dirname $this_file`

report_type=$1
if [ "$report_type" != "email" ] 
then
    report_type="cli"
fi

#
# include conf and func
#

. $this_dir/conf.sh
. $this_dir/compute.sh
. $this_dir/report/$report_type.sh


#
# get report
#

all_report="`get_report_title`"
for conf in $log_config
{
    domain=`echo $conf | awk 'BEGIN{FS = "|";}{print $1}'`
    log_file="`echo $conf | awk 'BEGIN{FS = "|";}{print $2}'`"
    all_report=$all_report`get_single_report $domain $log_file`
}

#
# show report
#

logdate=`date -d "yesterday" +%Y-%m-%d`

if [ "$report_type" = "email" ] 
then
    echo -e $all_report | mail -s "$(echo -e "access log statistics $logdate `hostname` \nContent-Type: text/html;charset=utf-8")" ${report_email}
else
    echo -e $all_report
fi

