Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AO6zn-0008C6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 19:02:39 -0800
Received: from mekong.darkman.de ([217.69.160.53] helo=mail.darkman.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AO6zj-0004gs-3K
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 23 Nov 2003 19:02:35 -0800
Received: from darkman.de (ezri.darkman.de [23.23.23.42])
	by mail.darkman.de (Postfix) with ESMTP id 374F72EF84
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 24 Nov 2003 04:02:15 +0100 (CET)
Message-ID: <3FC174B6.4030908@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problem with 2.4.22-uml6 & skas...
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
Date: Mon, 24 Nov 2003 04:02:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi there,

i try to get 2.4.22-6 running with skas mode.

The host:
Running vanilla 2.4.22 with host-skas3.patch (applied without
any error), PROC_MM enabled.
GCC is 3.3.1
The box is running fine with the kernel.

The UML:
2.4.22 patched with uml6, skas enabled etc.pp.

Problem:
i start the uml with:
linux-2.4.22 ubd0=/home/uml1/uml/10/root_fs 
ubd1=/home/uml1/uml/10/swap.disk mem=64M con1=pts umid=uml10 
eth0=tuntap,uml10-eth0 devfs=mount
and it stops here:
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev

if i take a look at the host, i can see the following:
uml1     12180  0.0  0.0     4    0 pts/4    TW   03:41   0:00 
[linux-2.4.22-te]
uml1     12185  0.0  0.9 65956 4640 pts/4    S    03:41   0:00 
/home/uml1/uml/linux-2.4.22-test 

uml1     12186  0.0  0.9 65956 4640 pts/4    S    03:41   0:00 
/home/uml1/uml/linux-2.4.22-test 

uml1     12164 99.7  0.9 65956 4640 pts/4    R    03:41   4:13 
/home/uml1/uml/linux-2.4.22-test

(one uml running with nearly 100% cpu usage..)
attached strace on that one, i get:


--- SIGSEGV (Segmentation fault) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [], 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM PROF IO], NULL, 8) = 0
getpid()                                = 12164
write(12, "7\0\0\0\0`\1@\0\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
28) = 28
write(12, "6\0\0\0\0`\1@\0\20\0\0\7\0\0\0\21\0\0\0\3\0\0\0\0P\\\0"..., 
28) = 28
sigreturn()                             = ? (mask now [])
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [], 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM PROF IO], NULL, 8) = 0
getpid()                                = 12164
write(12, "7\0\0\0\0`\1@\0\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
28) = 28
write(12, "6\0\0\0\0`\1@\0\20\0\0\7\0\0\0\21\0\0\0\3\0\0\0\0P\\\0"..., 
28) = 28
sigreturn()                             = ? (mask now [])
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
and so on...

with mode=tt the kernel runs. Then i tried another kernel from
kernels.usermodelinux.org:
linux-2.4.23-rc3-djc3-6um (nomods)
and: it works.
I talked to david and he said the kernel builds without problems
which is not the case on my host. I get this error:
bugs.c: In function `disable_lcall':
bugs.c:111: error: storage size of `ldt' isn't known
bugs.c:118: warning: implicit declaration of function `modify_ldt'
bugs.c:111: warning: unused variable `ldt'

which is fixed with a patch from:
http://people.0x63.nu/~andersg/uml-minor-fixes.diff

so, for now, i don't have more ideas to solve this Problem. If someone
of you has an idea or fix, please commit ;)

Thanks and regards,
Sven



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
