Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1WJ6H0-0008Ru-D4
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:05:34 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WJ6Gz-0003mu-9O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:05:34 +0000
Message-ID: <530F8C69.9080801@panasas.com>
Date: Thu, 27 Feb 2014 21:05:13 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] sysreq t back traces stopped working please help
To: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi Richard, uml hackers

Since some time my "echo t > /proc/sysrq-trigger" stopped producing the proper global back-traces for all Kernel threads.
All I get is:

Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]      ksoftirqd/0     3     58344.325336    124146   120               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]     kworker/0:0H     5      3160.151405         5   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]          khelper     7         8.451419         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]        kdevtmpfs     8      5439.251379       169   120               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]            netns     9        10.451418         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]        writeback    37        13.451416         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]           bioset    39        12.451417         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]          kblockd    41        11.951416         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]          kswapd0    66        22.451413         3   120               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]    fsnotify_mark    67      1686.151405         6   120               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]          deferwq   219        25.451413         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]      jbd2/ubda-8   220     58318.325347       330   120               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]  ext4-rsv-conver   221        24.951412         2   100               0               0               0.000000               0.000000     
          0.000000 /
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]  systemd-journal   233      2254.451426       466   120               0               0               0.000000               0.000000     
          0.000000 /system/systemd-journald.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]    systemd-udevd   238       426.451404       696   120               0               0               0.000000               0.000000     
          0.000000 /system/systemd-udevd.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]         rsyslogd   485       447.701421        38   120               0               0               0.000000               0.000000     
          0.000000 /system/rsyslog.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]      in:imuxsock   549       447.701421       221   120               0               0               0.000000               0.000000     
          0.000000 /system/rsyslog.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]        in:imklog   550       447.701421        29   120               0               0               0.000000               0.000000     
          0.000000 /system/rsyslog.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]    rs:main Q:Reg   551       450.701421       255   120               0               0               0.000000               0.000000     
          0.000000 /system/rsyslog.service
Feb 27 12:47:32 fc18-buml18 kernel: [189390.940000]   systemd-logind   486      1540.451422       282   120               0               0               0.000000               0.000000     
          0.000000 /system/systemd-logind.service

	..... etc ...

Single line statistics per thread. I'm based on "make defconfig" plus some additional "YESs".
Is there something more (new) I need to set to get this working? If not do you have a theory
or I should start bisecting?

(Using Fedora 18 um image, on Fedora 18 host 64bit both)

Thanks lots in advance
Boaz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

