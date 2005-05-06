Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUBi7-0008AY-Lv	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:54:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DUBi6-0004u5-UM	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:54:19 -0700
Message-Id: <200505062249.j46MncJb010495@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 12/12] UML - x86_64 fixes
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
Date: Fri, 06 May 2005 18:49:38 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This fixes some x86_64 bugs -
    maybe_map returns -1 on error instead of 0, which is interpretted as
physical address 0
    removed an include of ipc.h, which isn't needed
    fixed the calculation of signal frame location
    the signal delivery code is now immune to the stack expansion check
    added a missing include

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/skas/uaccess.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/skas/uaccess.c	2005-05-05 12:43:02.000000000 -0400
@@ -29,9 +29,12 @@
 	if(IS_ERR(phys) || (is_write && !pte_write(pte))){
 		err = handle_page_fault(virt, 0, is_write, 1, &dummy_code);
 		if(err)
-			return(0);
+			return(-1UL);
 		phys = um_virt_to_phys(current, virt, NULL);
 	}
+        if(IS_ERR(phys))
+                phys = (void *) -1;
+
 	return((unsigned long) phys);
 }
 
@@ -42,7 +45,7 @@
 	int n;
 
 	addr = maybe_map(addr, is_write);
-	if(addr == -1)
+	if(addr == -1UL)
 		return(-1);
 
 	page = phys_to_page(addr);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/syscall_kern.c	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/syscall_kern.c	2005-05-05 12:43:02.000000000 -0400
@@ -17,7 +17,6 @@
 #include "linux/utime.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
-#include "asm/ipc.h"
 #include "kern_util.h"
 #include "user_util.h"
 #include "sysdep/syscalls.h"
Index: linux-2.6.12-rc3-mm/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/trap_kern.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/trap_kern.c	2005-05-05 12:43:02.000000000 -0400
@@ -48,7 +48,7 @@
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
-	else if(!ARCH_IS_STACKGROW(address))
+	else if(is_user && !ARCH_IS_STACKGROW(address))
 		goto out;
 	else if(expand_stack(vma, address)) 
 		goto out;
Index: linux-2.6.12-rc3-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-x86_64/signal.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-x86_64/signal.c	2005-05-05 12:43:02.000000000 -0400
@@ -168,7 +168,7 @@
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	frame -= 128;
+	((unsigned char *) frame) -= 128;
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
Index: linux-2.6.12-rc3-mm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-x86_64/syscalls.c	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-x86_64/syscalls.c	2005-05-05 12:43:02.000000000 -0400
@@ -44,6 +44,8 @@
 #ifdef CONFIG_MODE_SKAS
 extern int userspace_pid[];
 
+#include "skas_ptrace.h"
+
 long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
 	struct ptrace_ldt ldt;



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
