Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqZjG-0004Ng-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 08:27:46 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CqZjF-0000Ko-96 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 08:27:46 -0800
Message-Id: <200501171627.j0HGRXh10942@trolli.pdb.fsc.net>
From: bstroesser@fujitsu-siemens.com
Subject: [uml-devel] [patch 1/1] UML i386 and x86_64: compare stack pointer to
	failing address before expanding stack
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
Date: Mon, 17 Jan 2005 17:27:18 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

When a page fault occurs on an address below the stack-vma,
UML tries to expand the stack.
On i386 and x86_64, the failing address is compared to the
current userspace stack pointer. If the failing address is
below "esp-32" resp. "rsp-128", stack expansion is not
allowed, and a SIGSEGV is given to the user.
This patch makes UML behave like i386/x86_64.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN include/asm-um/processor-i386.h~stack_grow_check_SP include/asm-um/processor-i386.h
--- linux-2.6.10-mm3/include/asm-um/processor-i386.h~stack_grow_check_SP	2005-01-17 14:39:32.349020626 +0100
+++ linux-2.6.10-mm3-root/include/asm-um/processor-i386.h	2005-01-17 15:13:54.030087304 +0100
@@ -32,6 +32,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+	(address + 32 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
diff -puN include/asm-um/processor-x86_64.h~stack_grow_check_SP include/asm-um/processor-x86_64.h
--- linux-2.6.10-mm3/include/asm-um/processor-x86_64.h~stack_grow_check_SP	2005-01-17 14:39:51.373082903 +0100
+++ linux-2.6.10-mm3-root/include/asm-um/processor-x86_64.h	2005-01-17 15:13:41.320365765 +0100
@@ -25,6 +25,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+        (address + 128 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
diff -puN arch/um/kernel/trap_kern.c~stack_grow_check_SP arch/um/kernel/trap_kern.c
--- linux-2.6.10-mm3/arch/um/kernel/trap_kern.c~stack_grow_check_SP	2005-01-17 14:45:34.450017573 +0100
+++ linux-2.6.10-mm3-root/arch/um/kernel/trap_kern.c	2005-01-17 14:53:23.114777237 +0100
@@ -48,6 +48,8 @@ int handle_page_fault(unsigned long addr
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
+	else if(!ARCH_IS_STACKGROW(address))
+		goto out;
 	else if(expand_stack(vma, address)) 
 		goto out;
 
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
