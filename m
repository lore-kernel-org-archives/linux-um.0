Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXNZb-0001pM-Ou for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:47 -0700
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HXNZa-0003yY-2k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 13:19:47 -0700
From: <gregkh@suse.de>
Date: Fri, 30 Mar 2007 13:18:10 -0700
In-Reply-To: <20070323193730.GA9519@c2.user-mode-linux.org>
Message-Id: <20070330201942.D64D0C3B8A2@imap.suse.de>
Subject: [uml-devel] patch uml-host-vdso-fix.patch queued to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, gregkh@suse.de, jdike@linux.intel.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML - host VDSO fix

to the 2.6.20-stable tree.  Its filename is

     uml-host-vdso-fix.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Fri Mar 23 12:41:21 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 23 Mar 2007 15:37:30 -0400
Subject: UML - host VDSO fix
To: stable@kernel.org
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20070323193730.GA9519@c2.user-mode-linux.org>
Content-Disposition: inline

From: Jeff Dike <jdike@addtoit.com>

This fixes a problem seen by a number of people running UML on newer host
kernels.  init would hang with an infinite segfault loop.

It turns out that the host kernel was providing a AT_SYSINFO_EHDR of
0xffffe000, which faked UML into believing that the host VDSO page could be
reused.  However, AT_SYSINFO pointed into the middle of the address space, and
was unmapped as a result.  Because UML was providing AT_SYSINFO_EHDR and
AT_SYSINFO to its own processes, these would branch to nowhere when trying to
use the VDSO.

The fix is to also check the location of AT_SYSINFO when deciding whether to
use the host's VDSO.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.17.orig/arch/um/os-Linux/elf_aux.c	2007-02-23 15:00:51.000000000 -0500
+++ linux-2.6.17/arch/um/os-Linux/elf_aux.c	2007-02-23 15:09:58.000000000 -0500
@@ -39,6 +39,9 @@ __init void scan_elf_aux( char **envp)
 		switch ( auxv->a_type ) {
 			case AT_SYSINFO:
 				__kernel_vsyscall = auxv->a_un.a_val;
+				/* See if the page is under TASK_SIZE */
+				if (__kernel_vsyscall < (unsigned long) envp)
+					__kernel_vsyscall = 0;
 				break;
 			case AT_SYSINFO_EHDR:
 				vsyscall_ehdr = auxv->a_un.a_val;

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable


Patches currently in stable-queue which might be from jdike@addtoit.com are


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
