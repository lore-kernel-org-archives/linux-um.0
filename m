Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDRjf-0005qy-E3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:02:27 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDRjd-0005PV-00 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:02:27 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C45@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Security patch 1 of 3
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
Date: Fri, 1 Oct 2004 20:01:10 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

This is the first one of a small series of patches. With all of them
applied,
it should no longer be possible to execute a systemcall on the host by
singlestepping a process. There is only one hole left, that I could find
while testing: in SKAS mode a singlestepped process can jump to the
vsyscall page.
In SKAS mode the kernel can't read that page with copy_from_user() while
executing
is_syscall(). Thus the sysenter instruction is not detected, the
systemcall may be
executed on the host.
I will try to fix this by enabling the vsyscall-page in UML. If I can't
do this,
at least I will use the host's vsyscall information to detect a jump
into the
Vsyscall page and read the data from there directly.


This patch
- changes the format of the error message in is_syscall()
- makes is_syscall() detect sysenter-syscalls, too
- makes is_syscall() overlook systemcalls with invalid systemcall
numbers.
  This is necessary, because the host kernel will skip syscall-tracing
in this case.

With the patch applied UML will detect all systemcalls in tt-mode. No
change in skas-mode.

Bodo


--- linux-2.6.9-rc2-orig/arch/um/sys-i386/ptrace.c	2004-09-13
07:32:56.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/sys-i386/ptrace.c	2004-10-01
16:42:53.997017819 +0200
@@ -7,6 +7,7 @@
 #include "asm/elf.h"
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
+#include "asm/unistd.h"
 #include "ptrace_user.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/sc.h"
@@ -23,11 +24,12 @@

	n = copy_from_user(&instr, (void *) addr, sizeof(instr));
	if(n){
-		printk("is_syscall : failed to read instruction from
0x%lu\n", 
+		printk("is_syscall : failed to read instruction from
0x%lx\n", 
		       addr);
 		return(0);
 	}
-	return(instr == 0x80cd);
+	return( (instr == 0x80cd || instr == 0x340f) &&
+	        PT_REGS_EAX(&current->thread.regs) < NR_syscalls);
 }
 
 /* determines which flags the user has access to. */
  


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
