Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhG2k-0007bN-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 16:41:54 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EhG2i-00089d-IB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 16:41:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 87BBFAF078
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 30 Nov 2005 00:41:32 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21951-11 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Wed, 30 Nov 2005 00:41:19 +0000 (GMT)
Received: from [192.168.0.2] (host-87-74-21-109.bulldogdsl.com [87.74.21.109])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 6BAA6AF075
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 30 Nov 2005 00:41:19 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1133311286.13162.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] testing of 2.6.14/2.6.15-rc amd64 guests
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
Date: Wed, 30 Nov 2005 00:41:26 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

This was a lot quicker than testing x86 guests...
(and solved some x86 questions I had too)

* 2.6.14-bs2 from Blaisorblade's site:
- in skas0 mode:
Does not show anything after:
"VFS: Mounted root (ext3 filesystem) readonly."
And 2 processes eat up all the CPU (until I savagely kill them).
- in TT mode:
VFS: Mounted root (ext3 filesystem) readonly.
Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x0

Modules linked in:
Pid: 1, comm: init Not tainted 2.6.14-bs2
RIP: 0000:[<0000000000000000>]
RSP: 0000000060483c30  EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000601ca541
RDX: 000000006002b00d RSI: 0000000000000001 RDI: 0000000060483ad0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 000000000000000a R15: 00000000602d1988
Call Trace:
604836d8:  [<60016d6f>] panic_exit+0x2f/0x50
604836f8:  [<60044f1b>] notifier_call_chain+0x2b/0x50
60483728:  [<600315f4>] panic+0xe4/0x180
60483768:  [<601ca541>] sigprocmask+0x11/0x40
60483798:  [<60015e5c>] handle_page_fault+0x1dc/0x290
60483818:  [<60016104>] segv+0x1f4/0x2f0
60483828:  [<601ca6a5>] sigemptyset+0x15/0x40
60483838:  [<600138e1>] change_sig+0x61/0x80
60483858:  [<6001a0ac>] __do_copy_from_user+0x9c/0x120
604838a8:  [<601ca6a5>] sigemptyset+0x15/0x40
604838b8:  [<60013951>] change_signals+0x51/0x80
60483928:  [<600164e5>] segv_handler+0xa5/0x110
60483968:  [<60019ab9>] sig_handler_common_tt+0x109/0x1b0
604839d8:  [<6002b04a>] sig_handler+0x1a/0x30
604839e8:  [<601ca2c0>] __restore_rt+0x0/0x10
60483a78:  [<6002b00d>] run_kernel_thread+0x2d/0x50
60483a88:  [<601ca541>] sigprocmask+0x11/0x40
60483ae0:  [<6000e1b0>] init+0x0/0x160
60483b08:  [<6002b00d>] run_kernel_thread+0x2d/0x50
60483b88:  [<6000e1b0>] init+0x0/0x160
60483b98:  [<6001399e>] unblock_signals+0xe/0x10
60483ba8:  [<60017ed6>] new_thread_handler+0x166/0x1a0
60483cd8:  [<601ca541>] sigprocmask+0x11/0x40


* The same kernel compiled here using hardened GCC:
gcc (GCC) 3.4.4 (Gentoo Hardened 3.4.4-r1, HTB-3.4.4-1.00, ssp-3.4.4-1.0, pie-8.7.8)
gives the same error reported earlier for x86 guests:
the guest exits after spinning for a while on signals:
rt_sigprocmask(SIG_SETMASK, NULL, [WINCH], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [ALRM VTALRM WINCH IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [], NULL, 8)  = 0
(that's in skas mode)

* The same thing happens with most kernels I've tried from 2.6.13 to
2.6.15-rc3. Seems like this compiler is doing something unusual because
when I use FC4's: gcc (GCC) 4.0.2 20051125 (Red Hat 4.0.2-8)
It works just fine (skas0).
So I guess we can assume that this is the cause of the spinning kernel
I reported for x86.
What can I do to figure out what is wrong with this compiler/compiled
code? (I have not noticed any problems using it before - and the whole
system is built on it, being Gentoo)

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
