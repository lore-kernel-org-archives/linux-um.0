Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOm5I-0003PI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 14:55:04 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AOm5H-00077x-Pm
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 14:55:03 -0800
Message-ID: <021d01c3b3a7$bfd87450$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] ps-utils just give me "5"
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
Date: Tue, 25 Nov 2003 23:59:14 +0100
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

Hi !
Can someone explain, why watching my uml-instances , top/pstree just gives me 
"five" (see below) and ps shows it very different (the "[5]" is still there, though) ?
I don`t have a clue and this looks strange to me.
i run linux-2.6.0-test9-1um (self compiled) on linux-2.6.0-test9 with skas patch (also 
self compiled). the 2 running instances are named suse9-1 and suse9-2 via "umid" commandline
parameter.
i know, that there are general differences in the way, process names are shown, depending 
on the utility you use. e.g, on our solaris server, prstat shows oracle process names very 
different from ps, too.
but here, the "5" just isn`t understandable for me. where does that "5" come from? 
Is it a "internal process name" hardcoded in the binary (here "linux-2.6.0-test9-1um")or is
it a more general "feature of a process" uml is using? it seems processes can "rename" 
itself - i saw this sometimes while doing some admin work(was it sendmail?).
sorry - if this sounds dumb , but can someone point me to some general docs to read about 
"process/commandline naming internals" (i.e. how and why the process tools handle that 
different) ? i would like to understand the details. furthermore i would like to fix the
"wrong" uml name and would like to see the umid show up.(or need i just play around with 
top/pstree params? i tried some, but no difference) 

regards
roland



< top >

     top - 12:35:39 up  1:31,  7 users,  load average: 0.60, 0.14, 0.04
     Tasks:  74 total,   3 running,  69 sleeping,   2 stopped,   0 zombie
     Cpu(s):  37.2% user,  50.7% system,   0.0% nice,   0.0% idle,  12.2% IO-wait
     Mem:    515744k total,   407664k used,   108080k free,    40024k buffers
     Swap:  1028120k total,        0k used,  1028120k free,   316464k cached

       PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND 
-->   1689 root      16   0 33848  28m  32m R 40.4  5.6   0:33.48 5
      1655 testuser  15   0  6700 3668 5400 S 26.9  0.7   0:02.30 xterm 
      1439 root      15   0  141m  10m 132m S 15.8  2.1   0:02.98 X 
-->   1691 root      15   0   496  496  496 T  2.6  0.1   0:03.32 5
-->   1697 root      15   0 33848  28m  32m S  1.0  5.6   0:00.07 5   
-->   1696 root      15   0 33848  28m  32m S  0.7  5.6   0:00.63 5
-->   1609 root      15   0 33848  28m  32m S  0.3  5.6   0:24.64 5 
      1856 root      16   0  1876  956 1680 R  0.3  0.2   0:00.05 top
         1 root      16   0   620  256  476 S  0.0  0.0   0:04.22 init
         2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
         3 root       5 -10     0    0    0 S  0.0  0.0   0:00.02 events/0
         4 root       5 -10     0    0    0 S  0.0  0.0   0:00.06 kblockd/0
         6 root      15   0     0    0    0 S  0.0  0.0   0:00.11 pdflush
         7 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0
         8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
         9 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
--snipp--         


< pstree -a >

   `-suse9-1.sh ./suse9-1.sh 
-->      `-5 (suse9-1)\040[/sbin/mingetty]
-->         |-(5)
-->         |-5 (suse9-1)\040[/sbin/mingetty]
-->         |-5 (suse9-1)\040[/sbin/mingetty]
-->         |-5 (suse9-1)\040[/sbin/hwclock] 
            `-xterm -T Virtual\040Console\040#1\040(suse9-1) -e /usr/lib/uml/port-helper 
                `-port-helper -uml-socket /tmp/xterm-pipezHfZ6h  

     -suse9-2.sh ./suse9-2.sh 
-->       `-5 (suse9-2)\040[find] 
-->          |-(5)
-->          |-5 (suse9-2)\040[find]
-->          |-5 (suse9-2)\040[find]
-->          |-5 (suse9-2)\040[/sbin/hwclock]
             `-xterm -T Virtual\040Console\040#1\040(suse9-2) -e /usr/lib/uml/port-helper 
                 `-port-helper -uml-socket /tmp/xterm-pipeRyRYM4 
--snipp--



< ps -ef >

     testuser  1530  1480  0  1908 ?        00:00:02 xterm
     testuser  1532  1530  0  1908 pts/1    00:00:00 bash
     root      1544  1532  0  1908 pts/1    00:00:00 su
     root      1608  1545  0  1908 pts/1    00:00:00 /bin/bash ./suse9-1.sh
     root      1609  1608  0  1908 pts/1    00:00:25 ./linux-2.6.0-test9-1um (suse9-1) [/sbin/m
-->  root      1611  1609  0  1908 pts/1    00:00:02 [5]
     root      1616  1609  0  1908 pts/1    00:00:00 ./linux-2.6.0-test9-1um (suse9-1) [/sbin/m
     root      1617  1609  0  1908 pts/1    00:00:00 ./linux-2.6.0-test9-1um (suse9-1) [/sbin/m
     root      1618  1609  0  1908 pts/1    00:00:00 xterm -T Virtual Console #1 (suse9-1) -e /
     root      1620  1618  0  1908 ?        00:00:00 /usr/lib/uml/port-helper -uml-socket /tmp/
     root      1621  1609  0  1908 pts/2    00:00:00 ./linux-2.6.0-test9-1um (suse9-1) [/sbin/h
     testuser  1627  1625  0  1908 pts/3    00:00:00 bash
     root      1640  1639  0  1908 pts/3    00:00:00 bash
     testuser  1655  1480  0  1908 ?        00:00:24 xterm
     root      1667  1666  0  1908 pts/4    00:00:00 bash
     root      1688  1667  0  1908 pts/4    00:00:00 /bin/bash ./suse9-2.sh
     root      1689  1688  0  1908 pts/4    00:01:16 ./linux-2.6.0-test9-1um (suse9-2) [find]  
-->  root      1691  1689  0  1908 pts/4    00:00:05 [5]
     root      1696  1689  0  1908 pts/4    00:00:00 ./linux-2.6.0-test9-1um (suse9-2) [find]
     root      1697  1689  0  1908 pts/4    00:00:00 ./linux-2.6.0-test9-1um (suse9-2) [find]
     root      1698  1689  0  1908 pts/4    00:00:00 xterm -T Virtual Console #1 (suse9-2) -e /
     root      1700  1698  0  1908 ?        00:00:00 /usr/lib/uml/port-helper -uml-socket /tmp/
     root      1701  1689  0  1908 pts/5    00:00:00 ./linux-2.6.0-test9-1um (suse9-2) [/sbin/h
     root      1753     1  0  1908 ?        00:00:00 [pdflush]
     testuser  1857  1480  0  1908 ?        00:00:00 xterm
     testuser  1859  1857  0  1908 pts/6    00:00:00 bash
--snipp--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
