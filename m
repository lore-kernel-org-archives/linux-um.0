Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uUYT-0001hz-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 03:08:01 -0700
Received: from mout1.freenet.de ([194.97.50.132])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uUYS-0004Dg-JS
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 03:08:00 -0700
Received: from [194.97.50.135] (helo=mx2.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.21)
	id 19uUYQ-0003km-Io
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 12:07:58 +0200
Received: from b2d9a.pppool.de ([213.7.45.154] helo=home.petschge.de)
	by mx2.freenet.de with esmtp (Exim 4.21 #5)
	id 19uUYN-0003sI-Iu
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 12:07:56 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 260603BC57
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed,  3 Sep 2003 11:58:13 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id DD7693BC56
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed,  3 Sep 2003 11:58:11 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] run away 2.6.0 
References: <200309021220.13334.petschge@gmx.de> <200309021850.h82Io9Hx001652@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030903095811.DD7693BC56@home.petschge.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 03 Sep 2003 11:58:11 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

Jeff Dike wrote:
> Figure out what process is causing the hang and get a stack trace from it.

Ok, it is the shutdown process itself. After issueing a shutdown and after 
the the cpu load hits the roof, I still can login into the uml guest and I 
got the following top screen:

11:35am  up 12298 days,  9:35,  0 users,  load average: 0.48, 0.52, 0.25
14 processes: 12 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
Mem:    29176K av,    7992K used,   21184K free,       0K shrd,     204K 
buff
Swap:       0K av,       0K used,       0K free                    3156K 
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   35 root      24   0  1376  620  1324 R    17.7  2.1   0:06 shutdown
   47 root      22   0  1744  944  1652 R     0.7  3.2   0:00 top
    1 root      15   0    28   28    12 S     0.0  0.0   0:00 init
    2 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd/0
    3 root       5 -10     0    0     0 SW<   0.0  0.0   0:00 events/0
    4 root      15 -10     0    0     0 SW<   0.0  0.0   0:00 kblockd/0
    5 root      25   0     0    0     0 SW    0.0  0.0   0:00 pdflush
    6 root      15   0     0    0     0 SW    0.0  0.0   0:00 pdflush
    7 root      25   0     0    0     0 SW    0.0  0.0   0:00 kswapd0
    8 root      10 -10     0    0     0 SW<   0.0  0.0   0:00 aio/0
   42 root      18   0  2056  952  1752 S     0.0  3.2   0:00 login
   44 root      16   0  2308 1128  2224 S     0.0  3.8   0:00 run
   45 root      21   0  2048 1156  1752 S     0.0  3.9   0:00 login
   46 root      23   0  2356 1320  2224 S     0.0  4.5   0:00 bash

So I restarted the uml guest with the debug swith and did attache gdb to the 
shutdown process and got the following backtrace:

(gdb) bt
#0  0xa01b3fa1 in __kill ()
#1  0xa0037714 in os_usr1_process (pid=3486) at 
arch/um/os-Linux/process.c:90
#2  0xa0024378 in set_user_mode (t=0x0) at 
arch/um/kernel/tt/process_kern.c:446
#3  0xa0025ca7 in sig_handler_common_tt (sig=12, sc_ptr=0xa0b67d28)
    at arch/um/kernel/tt/trap_user.c:43
#4  0xa0021fdf in sig_handler (sig=12, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, 
__dsh = 0, edi = 134526247, esi = 0, ebp = 2684353100, esp = 2684353048, 
ebx = 4294967295, edx = 0, ecx = 2684353144, eax = 4294967286, trapno = 14, 
err = 6, eip = 1074537161, cs = 35, __csh = 0, eflags = 2097670, 
esp_at_signal = 2684353048, ss = 43, __ssh = 0, fpstate = 0xa0b67d80, 
oldmask = 503390208, cr2 = 1075040288})
    at arch/um/kernel/trap_user.c:103
#5  <signal handler called>
#6  0x400c22c9 in ?? ()
#7  0x080499d0 in ?? ()
#8  0x08049bdf in ?? ()
#9  0x08049cf6 in ?? ()
#10 0x0804a8f3 in ?? ()
#11 0x40035991 in ?? ()

So I need to get a shutdown with debugging sysmbols compiled in, right?

mfg,
Patrick "Petschge" Kilian

PS.: The uptime looks pretty strange, but I can reproduce this big uptime 
value.

-- 
Erst wenn der letzte FTP Server kostenpflichtig, der letzte
GNU-Sourcecode verkauft, der letzte Algorithmus patentiert, der letzte
Netzknoten kommerzialisiert, die letzte Newsgroup moderiert wird,
werdet Ihr merken, dass man mit Geld allein nicht programmieren kann.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
