Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d3-0004Vj-3O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:33 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d2-0007eF-9h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:33 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183548.B9723310BD@zion>
Subject: [uml-devel] [patch 4/8] uml: disallow stack access below $esp like
	i386 / x86_64 [before 2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:48 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

When a page fault occurs on an address below the stack-vma,
UML tries to expand the stack.
On i386 and x86_64, the failing address is compared to the
current userspace stack pointer. If the failing address is
below "esp-32" resp. "rsp-128", stack expansion is not
allowed, and a SIGSEGV is given to the user.
This patch makes UML behave like i386/x86_64.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/trap_kern.c        |    2 ++
 linux-2.6.11-paolo/include/asm-um/processor-i386.h   |    3 +++
 linux-2.6.11-paolo/include/asm-um/processor-x86_64.h |    3 +++
 3 files changed, 8 insertions(+)

diff -puN arch/um/kernel/trap_kern.c~uml-stack-expansion arch/um/kernel/trap_kern.c
--- linux-2.6.11/arch/um/kernel/trap_kern.c~uml-stack-expansion	2005-02-04 06:18:18.689557088 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/trap_kern.c	2005-02-04 06:18:18.739549488 +0100
@@ -48,6 +48,8 @@ int handle_page_fault(unsigned long addr
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
+	else if(!ARCH_IS_STACKGROW(address))
+		goto out;
 	else if(expand_stack(vma, address)) 
 		goto out;
 
diff -puN include/asm-um/processor-i386.h~uml-stack-expansion include/asm-um/processor-i386.h
--- linux-2.6.11/include/asm-um/processor-i386.h~uml-stack-expansion	2005-02-04 06:18:18.726551464 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-i386.h	2005-02-04 06:18:18.739549488 +0100
@@ -27,6 +27,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+       (address + 32 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
diff -puN include/asm-um/processor-x86_64.h~uml-stack-expansion include/asm-um/processor-x86_64.h
--- linux-2.6.11/include/asm-um/processor-x86_64.h~uml-stack-expansion	2005-02-04 06:18:18.736549944 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-x86_64.h	2005-02-04 06:18:18.740549336 +0100
@@ -17,6 +17,9 @@ struct arch_thread {
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
 
+#define ARCH_IS_STACKGROW(address) \
+        (address + 128 >= UPT_SP(&current->thread.regs.regs))
+
 #include "asm/processor-generic.h"
 
 #endif
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
