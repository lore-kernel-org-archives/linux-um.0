Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FY7s6-0006Az-V2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 13:41:26 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FY7s6-000065-TP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 13:41:26 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FY7s4-0006Mo-AP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 13:41:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604242237.52295.blaisorblade@yahoo.it>
Subject: [uml-devel] Running uml on 2.6.16.x kernels
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
Date: Mon, 24 Apr 2006 22:37:51 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I can't run a 64 bit UML on a 2.6.16.9 kernel. I get constantly this error 
with various binaries, some of which I'm sure worked on 2.6.15 host (I'm 
going to retest):

VFS: Mounted root (ext3 filesystem) readonly.
Warning: unable to open an initial console.
Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, 
errno = 0, status = 2943


Modules linked in:
Pid: 1, comm: init Not tainted 2.6.16-bb1
RIP: 0033:[<00000000400101ba>]
RSP: 0000007f7feafde8  EFLAGS: 00000246
RAX: 000000000050a000 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000026 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000040000000
R10: 0000000040000a18 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000040001dd0 R14: 0000000000000008 R15: 0000000000400040
Call Trace:
6031bc58:  [<6000fa4c>] panic_exit+0x27/0x42
6031bc68:  [<600312bd>] notifier_call_chain+0x1f/0x2f
6031bc88:  [<60023b6e>] panic+0xcf/0x165
6031bcc8:  [<60175bb9>] __libc_waitpid+0x39/0xc0
6031bcf8:  [<6001be7c>] set_signals+0x14/0x1f
6031bd08:  [<6004e99f>] sys_brk+0x100/0x10f
6031bd38:  [<6001e040>] move_registers+0x33/0x4a
6031bd68:  [<6001ef24>] userspace+0x1f8/0x248
6031bdc0:  [<6000a17f>] init+0x0/0x13d
6031bdd8:  [<6000ffd0>] new_thread_handler+0x121/0x12f
6031be38:  [<601699c0>] __restore_rt+0x0/0x10
6031bee8:  [<60169c79>] kill+0x9/0x20


I went looking for ptrace commits in -stable (I didn't check yet between 
2.6.15 and 2.6.16) and found that in 2.6.16.6 this was added: 

commit 18b1e8193eef97f3ac854276a7c4bacbb1bdfbd1 
author Roland McGrath <roland@redhat.com> mer, 12 apr 2006 16:30:20 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> lun, 17 apr 2006 13:16:06 -0700

    [PATCH] fix non-leader exec under ptrace

    This reverts most of commit 30e0fca6c1d7d26f3f2daa4dd2b12c51dadc778a.
    It broke the case of non-leader MT exec when ptraced.
    I think the bug it was intended to fix was already addressed by commit
    788e05a67c343fa22f2ae1d3ca264e7f15c25eaf.

And:

commit 30e0fca6c1d7d26f3f2daa4dd2b12c51dadc778a
[PATCH] ptrace/coredump/exit_group deadlock

was introduced between 2.6.14 and 2.6.15.

commit 788e05a67c343fa22f2ae1d3ca264e7f15c25eaf
[PATCH] fix do_coredump() vs SIGSTOP race

was introduced between 2.6.13 and 2.6.14.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
