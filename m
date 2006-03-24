Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqmy-0003Zo-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:32 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqmw-0001JM-R1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:32 -0800
Message-Id: <200603241814.k2OIElnT005535@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/16] UML - More carefully test whether we are in
	a system call
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
Date: Fri, 24 Mar 2006 13:14:47 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
 
For security reasons, UML in is_syscall() needs to have access to code
in vsyscall-page. The current implementation grants this access by
explicitly allowing access to vsyscall in access_ok_skas(). With this
change, copy_from_user() may be used to read the code.
Ptrace access to vsyscall-page for debugging already was implemented
in get_user_pages() by mainline.
In i386, copy_from_user can't access vsyscall-page, but returns EFAULT.
 
To make UML behave as i386 does, I changed is_syscall to use
access_process_vm(current) to read the code from vsyscall-page.
This doesn't hurt security, but simplifies the code and prepares
implementation of stub-vmas.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/ptrace.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/sys-i386/ptrace.c	2006-03-23 12:17:52.000000000 -0500
@@ -6,6 +6,7 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 #include "linux/sched.h"
+#include "linux/mm.h"
 #include "asm/elf.h"
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
@@ -26,9 +27,17 @@ int is_syscall(unsigned long addr)
 
 	n = copy_from_user(&instr, (void __user *) addr, sizeof(instr));
 	if(n){
-		printk("is_syscall : failed to read instruction from 0x%lx\n",
-		       addr);
-		return(0);
+		/* access_process_vm() grants access to vsyscall and stub,
+		 * while copy_from_user doesn't. Maybe access_process_vm is
+		 * slow, but that doesn't matter, since it will be called only
+		 * in case of singlestepping, if copy_from_user failed.
+		 */
+		n = access_process_vm(current, addr, &instr, sizeof(instr), 0);
+		if(n != sizeof(instr)) {
+			printk("is_syscall : failed to read instruction from "
+			       "0x%lx\n", addr);
+			return(1);
+		}
 	}
 	/* int 0x80 or sysenter */
 	return((instr == 0x80cd) || (instr == 0x340f));
Index: linux-2.6.15/arch/um/sys-x86_64/ptrace.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/ptrace.c	2006-03-23 12:50:15.000000000 -0500
+++ linux-2.6.15/arch/um/sys-x86_64/ptrace.c	2006-03-23 12:50:23.000000000 -0500
@@ -8,6 +8,7 @@
 #include <asm/ptrace.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/elf.h>
 
@@ -136,9 +137,28 @@ void arch_switch(void)
 */
 }
 
+/* XXX Mostly copied from sys-i386 */
 int is_syscall(unsigned long addr)
 {
-	panic("is_syscall");
+	unsigned short instr;
+	int n;
+
+	n = copy_from_user(&instr, (void __user *) addr, sizeof(instr));
+	if(n){
+		/* access_process_vm() grants access to vsyscall and stub,
+		 * while copy_from_user doesn't. Maybe access_process_vm is
+		 * slow, but that doesn't matter, since it will be called only
+		 * in case of singlestepping, if copy_from_user failed.
+		 */
+		n = access_process_vm(current, addr, &instr, sizeof(instr), 0);
+		if(n != sizeof(instr)) {
+			printk("is_syscall : failed to read instruction from "
+			       "0x%lx\n", addr);
+			return(1);
+		}
+	}
+	/* sysenter */
+	return(instr == 0x050f);
 }
 
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu )



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
