Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1rfY-0002Ro-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 11:13:48 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1rfX-0007Ho-HE
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 11:13:47 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id OAA19303
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 14:14:03 -0400 (EDT)
Message-ID: <3F708DFD.3050608@enterasys.com>
From: Demetrios Tsillas <jtsillas@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] debugging skas
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
Date: Tue, 23 Sep 2003 14:16:29 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I run linux under gdb with skas mode. Prior to running I disable
handling of SIGSEGV and SIGUSR1. Linux runs OK and I can
hit breakpoints and debug.

But, if I want to interrupt the uml by typing cntrl-C, it will not be
able to continue. Gdb says the program exited normally. Somehow
SIGINT is not being handled correctly?

thanks for your help.
-Jim.

(gdb) run ubd0=/tmp/cow.1,/usr/src/root_fs.0.2 mem=256m eth0=mcast

Program received signal SIGTRAP, Trace/breakpoint trap.
0xa000d000 in _start ()
(gdb) cont
^C
Program received signal SIGINT, Interrupt.
0xa02039cc in __libc_waitpid (pid=4244, stat_loc=0xad3bfcc0, options=2) 
at ../sysdeps/unix/sysv/linux/waitpid.c:28
(gdb) c

Program exited normally.
(gdb)





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
