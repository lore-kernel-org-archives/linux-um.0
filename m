Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdvgT-0007I9-5q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:12:05 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdvgS-000451-FA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:12:04 -0800
Mime-Version: 1.0
Message-Id: <a0602040abc20a9f6862e@[192.168.1.10]>
In-Reply-To: <200401061718.i06HILtd002620@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401060258.i062wuFI023117@ccure.user-mode-linux.org> 
	<a06020407bc208b5b5a7a@[192.168.1.10]>
	<200401061718.i06HILtd002620@ccure.user-mode-linux.org>
From: Johannes Formann <johannes@formann.de>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip
 0x400e51a4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 6 Jan 2004 19:11:42 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Jeff Chua <jchua@fedex.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

At 12:18 Uhr -0500 06.01.2004, Jeff Dike wrote:

>No, gdb it, put a breakpoint on panic, get a stack trace when it hits the
>breakpoint.

I'd run it once without a breakpoint set (after compiling it with 
debug symbols):

<much more>

Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) c
Continuing.
.

Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) c
Continuing.
Starting kernel log daemon: klogd
Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) bt
#0  0x40040781 in kill () from /lib/libc.so.6
#1  0x8006c91f in ?? ()
#2  0x800697ea in ?? ()
#3  0x8006919d in ?? ()
#4  0x80069968 in ?? ()
#5  0x80064309 in ?? ()
#6  0x8000cac4 in ?? ()
#7  0x800662b1 in ?? ()
#8  0x80069abf in ?? ()
#9  0x80066af5 in ?? ()
#10 0x80069afa in ?? ()
#11 0x80068ea7 in ?? ()
#12 0x800690da in ?? ()
#13 0x80069897 in ?? ()
#14 0x400406b8 in sigaction () from /lib/libc.so.6
#15 0x800697ea in ?? ()
(gdb) c
Continuing.

Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) bt
#0  0x40040781 in kill () from /lib/libc.so.6
#1  0x8006c91f in ?? ()
#2  0x800697ea in ?? ()
#3  0x8006919d in ?? ()
#4  0x80069968 in ?? ()
#5  0x80064309 in ?? ()
#6  0x8000cac4 in ?? ()
#7  0x800662b1 in ?? ()
#8  0x80069abf in ?? ()
#9  0x80066af5 in ?? ()
#10 0x80069afa in ?? ()
#11 0x80068ea7 in ?? ()
#12 0x800690da in ?? ()
#13 0x80069897 in ?? ()
#14 0x400406b8 in sigaction () from /lib/libc.so.6
#15 0x800697ea in ?? ()
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x8006a281 in ?? ()
(gdb) bt
#0  0x8006a281 in ?? ()
#1  0x8006a0f4 in ?? ()
#2  0x8006a13c in ?? ()
#3  0x8006a307 in ?? ()
#4  0x8006cc9c in ?? ()
#5  0x8002be5a in ?? ()
#6  0x80069abf in ?? ()
#7  0x80066af5 in ?? ()
#8  0x80069afa in ?? ()
#9  0x80068ea7 in ?? ()
#10 0x800690da in ?? ()
#11 0x80069897 in ?? ()
#12 0x400406b8 in sigaction () from /lib/libc.so.6
(gdb) c
Continuing.
Kernel panic: Kernel mode fault at addr 0x8814000, ip 0x400d93c4
.

Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) bt
#0  0x40040781 in kill () from /lib/libc.so.6
#1  0x8006c91f in ?? ()
#2  0x800697ea in ?? ()
#3  0x8006919d in ?? ()
#4  0x80069968 in ?? ()
#5  0x80064309 in ?? ()
#6  0x8000cac4 in ?? ()
#7  0x800662b1 in ?? ()
#8  0x80069abf in ?? ()
#9  0x80066af5 in ?? ()
#10 0x80069afa in ?? ()
#11 0x80068ea7 in ?? ()
#12 0x800690da in ?? ()
#13 0x80069897 in ?? ()
#14 0x400406b8 in sigaction () from /lib/libc.so.6
(gdb) c
Continuing.

Program received signal SIGUSR1, User defined signal 1.
0x40040781 in kill () from /lib/libc.so.6
(gdb) bt
#0  0x40040781 in kill () from /lib/libc.so.6
#1  0x8006c91f in ?? ()
#2  0x800697ea in ?? ()
#3  0x8006919d in ?? ()
#4  0x80069968 in ?? ()
#5  0x80064309 in ?? ()
#6  0x8000cac4 in ?? ()
#7  0x800662b1 in ?? ()
#8  0x80069abf in ?? ()
#9  0x80066af5 in ?? ()
#10 0x80069afa in ?? ()
#11 0x80068ea7 in ?? ()
#12 0x800690da in ?? ()
#13 0x80069897 in ?? ()
#14 0x400406b8 in sigaction () from /lib/libc.so.6
#15 0x800697ea in ?? ()
(gdb) c
Continuing.


Program exited normally.




I hope that can help you.

regards Johannes


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
