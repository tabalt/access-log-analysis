access log analysis
==================

分析访问日志，可通过终端或邮件的形式接收、显示分析报告。

### 一、下载

* 下载release版

	[https://github.com/tabalt/access-log-analysis/releases](https://github.com/tabalt/access-log-analysis/releases)

* 下载最新版本

	[https://github.com/tabalt/access-log-analysis/archive/master.zip](https://github.com/tabalt/access-log-analysis/archive/master.zip)


### 二、配置

* 创建配置文件

		cd ~/access-log-analysis
		cp conf.expmple conf.sh
		vim conf.sh

* 修改配置

	* 设置日志文件路径

			log_path=/usr/local/nginx/logs/archive

	* 设置接收报告邮箱
		
			report_email=""

	* 日志文件名的后缀，如前一天的日期后缀：
		
			log_file_suffix=`date -d "yesterday" +%Y%m%d`
		
	* 设置要分析的域名及日志文件

			log_config="
			www.abc.com|$log_path/www_abc_com_access.log-$log_file_suffix
			api.abc.com|$log_path/api_abc_com_access.log-$log_file_suffix
			"


### 三、使用

* 在终输出分析结果

		sh run.sh

* 通过邮件发送分析结果

		sh run.sh email

* crontab 中定时执行

	每天11点发送分析报告：

		0 11 * * *  cd /home/tabalt/access-log-analysis; /bin/bash run.sh email > /dev/null 2>&1


### 四、报表内容


* 目前报表中会包含如下内容：

	* 报表域名、日志文件、时间等
	* 概况
	* 访问ip前N名
	* 被访问的url前N名
	* 来源页面前N名
	* 404页面前N名
	* 蜘蛛统计
	* 搜索引擎来源统计

* 下面是终端下输出的报表形式：

		┌────────────────────────────────────────────
		│ 报表域名:	www.abc.com
		│ 日志文件:	/usr/local/nginx/logs/archive/www_abc_com_access.log-20141029
		│ 创建时间:	2014-10-30 11:38
		├────────────────────────────────────────────
		│
		│　+ 概况 +
		│　────────────
		│
		│　　总访问量:	1513
		│　　　总带宽:	69M
		│　　独立访客:	697
		│
		│
		│　+ 访问IP统计 +
		│　────────────
		│
		│		19 123.151.136.151
		│		18 220.170.90.112
		│		16 49.4.178.31
		│
		│
		│　+ 访问url统计 +
		│　────────────
		│
		│		...
		│	
		│
		│　+ 来源页面统计 +
		│　────────────
		│
		│		...
		│	
		│
		│　+ 404统计 +
		│　────────────
		│
		│		...
		│	
		│
		│　+ 蜘蛛统计 +
		│　────────────
		│
		│		...
		│	
		│
		│　+ 搜索引擎来源统计 +
		│　────────────
		│
		│		...
		│	
		└────────────────────────────────────────────

		
		

	

	







