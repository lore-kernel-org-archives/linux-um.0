Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <htmldeveloper@gmail.com>) id 1Ky2NH-0007sb-Pf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 10:46:03 +0000
Received: from yx-out-1718.google.com ([74.125.44.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ky2ND-0000t3-H3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 10:46:03 +0000
Received: by yx-out-1718.google.com with SMTP id 3so200673yxi.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 06 Nov 2008 02:45:58 -0800 (PST)
Message-ID: <804dabb00811060245t2dcae77bkcbba0156b9002c6d@mail.gmail.com>
Date: Thu, 6 Nov 2008 18:45:57 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] How to avoid stopping at gdb's "Program received signal
	SIGSEGV, Segmentation fault"?
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

When I run gdb ./linux (my UML-compiled kernel):

(gdb) run ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /mnt/hd0/download/linux-2.6-latest/uml/linux
ubda=/mnt/hd1/download/FedoraCore5-x86-root_fs mem=128M
Locating the bottom of the address space ...
Program received signal SIGSEGV, Segmentation fault.
0x080664ff in page_ok (page=<value optimized out>) at
/mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/sys-i386/task_size.c:31
31                      n = *address;

The flow keep stopping at the following message:

Program received signal SIGTRAP, Trace/breakpoint trap.

And I have to "next" many many times....the execution flow continue as
per normal.   But I would like to ignore the breakpoint trap, how?
(It is not a breakpoint by itself)   Execution flow continues normally
can be deduced because when I enter "bt" I can see the stacktrace
anytime:

(gdb) bt
#0  0x00556c2b in __i686.get_pc_thunk.bx () from /lib/ld-linux.so.2
#1  0x0054a8f8 in _dl_lookup_symbol_x () from /lib/ld-linux.so.2
#2  0x0054eac2 in _dl_fixup () from /lib/ld-linux.so.2
#3  0x00554260 in _dl_runtime_resolve () from /lib/ld-linux.so.2
#4  0x08066526 in page_ok (page=<value optimized out>) at
/mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/sys-i386/task_size.c:33
#5  0x08066607 in os_get_top_address () at
/mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/sys-i386/task_size.c:100
#6  0x0804a232 in linux_main (argc=3, argv=0xbffb46f4) at
/mnt/hd0/download/linux-2.6-latest/arch/um/kernel/um_arch.c:277
#7  0x0804ad16 in main (argc=3, argv=0xbffb46f4, envp=0xbffb4704) at
/mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/main.c:150


-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
