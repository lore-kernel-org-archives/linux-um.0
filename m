Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7HAP-0008DI-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 12:13:53 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7HAM-0001D9-ER
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 12:13:53 -0800
Message-ID: <45AE7DFC.9050704@nagafix.co.uk>
Date: Wed, 17 Jan 2007 19:50:20 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net> <45AE67C0.5080003@nagafix.co.uk>
In-Reply-To: <45AE67C0.5080003@nagafix.co.uk>
Subject: Re: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu
	6.06 LTS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

Don't know if that helps, but here it is: (sysrq t on 2.6.20-rc5):

[42949400.260000] SysRq : Show State
[42949400.260000]
[42949400.260000]                          free 
sibling
[42949400.260000]   task             PC    stack   pid father child 
younger older
[42949400.260000] ksoftirqd/0   S B7FE2400     0     2      1 
   3       (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08bcb280 080900ee 08bd3e94 
0805cc37 08bcb784
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08bd0000 
08bd3ec8 08059dba 08bcb280
[42949400.260000]        08bcb880 08bd0000 08bd0000 08bd0000 08bcb280 
00000000 08bd3ecc 08bd0000 Call Trace:
[42949400.260000] 08bd3e78:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08bd3e98:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08bd3ecc:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08bd3f3c:  [<08090141>] ksoftirqd+0x53/0xb5
[42949400.260000] 08bd3f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08bd3f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08bd3fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08bd3ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] watchdog/0    S B7FE2400     0     3      1 
   4     2 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08bcac80 080ab1d9 08bd7e9c 
0805cc37 08bcb184
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08bd4000 
08bd7ed0 08059dba 08bcac80
[42949400.260000]        08bcb880 08bd4000 08bd4000 08bd4000 08bcac80 
00000000 08bd7ed4 08bd4000 Call Trace:
[42949400.260000] 08bd7e80:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08bd7ea0:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08bd7ed4:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08bd7f44:  [<080ab235>] watchdog+0x5c/0x6b
[42949400.260000] 08bd7f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08bd7f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08bd7fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08bd7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] events/0      S B7FE2400     0     4      1 
   5     3 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08bca680 08bdbf40 08bdbe38 
0805cc37 08bcab84
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08bd8000 
08bdbe6c 08059dba 08bca680
[42949400.260000]        08bcb880 0807cf44 083dd690 00000000 08bca680 
08bdbf20 08bdbe70 08bd8000 Call Trace:
[42949400.260000] 08bdbe1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08bdbe3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08bdbe70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08bdbee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08bdbf5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08bdbf90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08bdbfcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08bdbffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] khelper       S B7FE2400     0     5      1 
   6     4 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08bca080 08bdff40 08bdfe38 
0805cc37 08bca584
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08bdc000 
08bdfe6c 08059dba 08bca080
[42949400.260000]        08bcb880 08bdfe70 080880ca 08bcfc64 08bca080 
08bdff20 08bdfe70 08bdc000 Call Trace:
[42949400.260000] 08bdfe1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08bdfe3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08bdfe70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08bdfee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08bdff5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08bdff90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08bdffcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08bdfffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] kthread       S B7FE2400     0     6      1    42 
         5 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08be1900 08be7f40 08be7e38 
0805cc37 08be1e04
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08be4000 
08be7e6c 08059dba 08be1900
[42949400.260000]        08bcb880 080880ca 08bcfbe8 00000003 08be1900 
08be7f20 08be7e70 08be4000 Call Trace:
[42949400.260000] 08be7e1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08be7e3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08be7e70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08be7ee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08be7f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08be7f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08be7fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08be7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] kblockd/0     S B7FE2400     0    42      6 
  43       (L-TLB)
[42949400.260000] 00000001 00000000 08be1900 08bbd380 00000000 08a63e38 
0805cc37 08bbd884
[42949400.260000]        08be1e04 08059d68 08be1900 08be1900 08a60000 
08a63e6c 08059dba 08bbd380
[42949400.260000]        08be1900 5a5a5a5a 5a5a5a5a 5a5a5a5a 08be1900 
08a63e6c 080877e0 08a60000 Call Trace:
[42949400.260000] 08a63e1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a63e3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a63e70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a63ee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08a63f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a63f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a63fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a63ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] cqueue/0      S B7FE2400     0    43      6 
  55    42 (L-TLB)
[42949400.260000] 00000001 00000000 08bca080 08bbcd80 00000000 08a67e38 
0805cc37 08bbd284
[42949400.260000]        08bca584 08059d68 08bca080 08bca080 08a64000 
08a67e6c 08059dba 08bbcd80
[42949400.260000]        08bca080 5a5a5a5a 5a5a5a5a 5a5a5a5a 08bca080 
08a67e6c 080877e0 08a64000 Call Trace:
[42949400.260000] 08a67e1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a67e3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a67e70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a67ee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08a67f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a67f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a67fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a67ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] pdflush       S B7FE2400     0    55      6 
  56    43 (L-TLB)
[42949400.260000] 00000001 00000000 08a5f280 08a5ec80 080b1dc7 08a7be5c 
0805cc37 08a5f184
[42949400.260000]        08a5f784 08059d68 08a5f280 08a5f280 08a78000 
08a7be90 08059dba 08a5ec80
[42949400.260000]        08a5f280 5a5a5a5a 0807cf25 083aed14 08a5ec80 
08a7bf38 08a7be94 08a78000 Call Trace:
[42949400.260000] 08a7be40:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a7be60:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a7be94:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a7bf04:  [<080b1d0c>] __pdflush+0x94/0x14f
[42949400.260000] 08a7bf20:  [<080b1e0d>] pdflush+0x46/0x48
[42949400.260000] 08a7bf5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a7bf90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a7bfcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a7bffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] pdflush       S B7FE2400     0    56      6 
  57    55 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 08a5f280 080b1dc7 08a77e5c 
0805cc37 08a5f784
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 08a74000 
08a77e90 08059dba 08a5f280
[42949400.260000]        08bcb880 0807ce7c 083aed14 00000000 08a5f280 
08a77f38 08a77e94 08a74000 Call Trace:
[42949400.260000] 08a77e40:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a77e60:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a77e94:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a77f04:  [<080b1d0c>] __pdflush+0x94/0x14f
[42949400.260000] 08a77f20:  [<080b1e0d>] pdflush+0x46/0x48
[42949400.260000] 08a77f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a77f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a77fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a77ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] kswapd0       S B7FE2400     0    57      6 
  58    56 (L-TLB)
[42949400.260000] 00000001 00000000 08bbc180 08a5f880 00000001 08a73e44 
0805cc37 08a5fd84
[42949400.260000]        08bbc684 08059d68 08bbc180 08bbc180 08a70000 
08a73e78 08059dba 08a5f880
[42949400.260000]        08bbc180 5a5a5a5a 5a5a5a5a 5a5a5a5a 08a5f880 
00000000 08a73e7c 08a70000 Call Trace:
[42949400.260000] 08a73e28:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a73e48:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a73e7c:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a73eec:  [<080b45cc>] kswapd+0xd4/0xf3
[42949400.260000] 08a73f5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a73f90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a73fcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a73ffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] aio/0         S B7FE2400     0    58      6 
692    57 (L-TLB)
[42949400.260000] 00000001 00000000 08bca080 08bbc180 00000000 08a6fe38 
0805cc37 08bbc684
[42949400.260000]        08bca584 08059d68 08bca080 08bca080 08a6c000 
08a6fe6c 08059dba 08bbc180
[42949400.260000]        08bca080 5a5a5a5a 5a5a5a5a 5a5a5a5a 08bca080 
08a6fe6c 080877e0 08a6c000 Call Trace:
[42949400.260000] 08a6fe1c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 08a6fe3c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 08a6fe70:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 08a6fee0:  [<0809ad99>] worker_thread+0xfa/0x162
[42949400.260000] 08a6ff5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 08a6ff90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 08a6ffcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 08a6fffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]
[42949400.260000] kjournald     S B7FE2400     0   692      6 
        58 (L-TLB)
[42949400.260000] 00000001 00000000 08bcb880 089de100 08ae13cc 088abe48 
0805cc37 089de604
[42949400.260000]        08bcbd84 08059d68 08bcb880 08bcb880 088a8000 
088abe7c 08059dba 089de100
[42949400.260000]        08bcb880 0807cf44 088abe99 00000015 089de100 
00000001 088abe80 088a8000 Call Trace:
[42949400.260000] 088abe2c:  [<0805cc37>] switch_to_skas+0x3b/0x85
[42949400.260000] 088abe4c:  [<08059dba>] _switch_to+0x39/0xbe
[42949400.260000] 088abe80:  [<082babd6>] schedule+0x44c/0x4c3
[42949400.260000] 088abef0:  [<081370c8>] kjournald+0x14b/0x1b0
[42949400.260000] 088abf5c:  [<0809d77e>] kthread+0x8f/0xb8
[42949400.260000] 088abf90:  [<0807c421>] run_kernel_thread+0x45/0x50
[42949400.260000] 088abfcc:  [<0805cd0d>] new_thread_handler+0x8c/0xb9
[42949400.260000] 088abffc:  [<a55a5a5a>] 0xa55a5a5a
[42949400.260000]

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
