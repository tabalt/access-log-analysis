#!/bin/bash

################################################
# email report functions
################################################

function get_report_title()
{
    echo "
<style>
    .table {
        width:90%;
        font-size:14px;
        margin-bottom : 10px;
    }
    .border {
        border-top : 1px solid #ccc;
        border-left : 1px solid #ccc;
    }
    .border td {
        line-height : 30px;
        padding : 5px;
        border-right : 1px solid #ccc;
        border-bottom : 1px solid #ccc;
    }
    .border .label-bg {
        background : #eee;
    }
    .text-center {
        text-align : center;
    }
    .w100 {
        width : 100px;
    }
</style>
<h3 class="text-center">$logdate 访问日志报表</h3>\n
"
}

function get_single_title()
{
    single_title="\n
<br /><hr /><br />\n
<table class=\"table border\" border=\"0\" bordercolor=\"black\" cellspacing=\"0\" cellpadding=\"0\"  >
    <tr>\n
        <td class=\"label-bg text-center w100\" width=\"100\">报表域名</td>\n
        <td>$1</td>\n
    </tr>\n
    <tr>\n
        <td class=\"label-bg text-center w100\" width=\"100\">日志文件</td>\n
        <td>$2</td>\n
    </tr>\n
    <tr>\n
        <td class=\"label-bg text-center w100\" width=\"100\">报表时间</td>\n
        <td>`date +%Y-%m-%d" "%H":"%M`</td>\n
    </tr>\n
    <tr>\n
    <td colspan=\"2\">\n
"
    echo $single_title
}

function get_block_title()
{
    echo "\n
<table class=\"table border\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >\n
    <tr>\n
        <td class=\"label-bg\" colspan=\"2\"><strong>$1</strong></td>\n
    </tr>\n
"
}

function get_tr_end()
{
    echo "\n
</tr>\n
";
}

function get_table_end()
{
    echo "\n
</table>\n
";
}

function format_list_data()
{
    data=$1
    echo "\n
<tr>\n
    <td style=\"word-wrap: break-word; line-height:20px;\">\n
    `awk $data 'BEGIN{FS="\\t";RS="\\n";OFS="\\\t";ORS="<br />\\\n"}{print $1,$2}'`\n
    </td>\n
</tr>
";
}

function get_overview()
{
    echo "
<table class=\"table border\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >\n
<tr>\n
    <td class=\"label-bg\"><strong>访问概况</strong></td>\n
    <td class=\"label-bg\"></td>\n
</tr>\n
<tr>\n
    <td class=\"text-center w100\">总访问量</td>\n
    <td>`get_total_visit $log_file`</td>\n
</tr>\n
<tr>\n
    <td class=\"text-center w100\">总带宽</td>\n
    <td>`get_total_bandwidth $log_file`</td>\n
</tr>\n
<tr>\n
    <td class=\"text-center w100\">独立访客</td>\n
    <td>`get_total_unique $log_file`</td>\n
</tr>\n
</table>\n
"
}

#
# get single report
#
function get_single_report()
{
    domain=$1
    log_file=$2
    
    single_report="
    
`get_single_title $domain $log_file`

`get_overview`

`get_block_title 访问IP统计`

`get_ip_top $log_file $top_item_num | format_list_data`

`get_table_end`

`get_block_title 访问url统计`

`get_url_top $log_file $top_item_num | format_list_data`

`get_table_end`

`get_block_title 来源页面统计`

`get_referer_top $log_file $top_item_num | format_list_data`

`get_table_end`

`get_block_title 404统计`

`get_notfound_top $log_file $top_item_num | format_list_data`

`get_table_end`

`get_block_title 蜘蛛统计`

`get_spider $log_file | format_list_data`

`get_table_end`

`get_block_title 搜索引擎来源统计`

`get_search_enigne $log_file | format_list_data`

`get_table_end`

        </td>
    </tr>
</table>

"
    echo $single_report
}
