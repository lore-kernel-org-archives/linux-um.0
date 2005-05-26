Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbQx0-0005Bd-7w	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:35:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbQwz-0007gg-MY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:35:38 -0700
Message-Id: <200505262230.j4QMUO9E014677@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/7] UML - Fix a couple of warnings
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
Date: Thu, 26 May 2005 18:30:24 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Eliminate an unused variable warning in ptrace.c and a size mismatch warning
by adding a cast to __pa.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/ptrace.c	2005-05-08 11:43:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/ptrace.c	2005-05-11 10:44:30.000000000 -0400
@@ -322,11 +322,9 @@ void syscall_trace(union uml_pt_regs *re
 					    UPT_SYSCALL_ARG2(regs),
 					    UPT_SYSCALL_ARG3(regs),
 					    UPT_SYSCALL_ARG4(regs));
-		else {
-                        int res = UPT_SYSCALL_RET(regs);
-			audit_syscall_exit(current, AUDITSC_RESULT(res),
-                                           res);
-                }
+		else audit_syscall_exit(current, 
+                                        AUDITSC_RESULT(UPT_SYSCALL_RET(regs)),
+                                        UPT_SYSCALL_RET(regs));
 	}
 
 	/* Fake a debug trap */
@@ -356,14 +354,3 @@ void syscall_trace(union uml_pt_regs *re
 		current->exit_code = 0;
 	}
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/include/asm-um/page.h
===================================================================
--- linux-2.6.12-rc.orig/include/asm-um/page.h	2005-05-11 10:18:52.000000000 -0400
+++ linux-2.6.12-rc/include/asm-um/page.h	2005-05-11 10:37:30.000000000 -0400
@@ -98,7 +98,13 @@ extern unsigned long uml_physmem;
 
 extern unsigned long to_phys(void *virt);
 extern void *to_virt(unsigned long phys);
-#define __pa(virt) to_phys((void *) virt)
+
+/* Cast to unsigned long before casting to void * to avoid a warning from
+ * mmap_kmem about cutting a long long down to a void *.  Not sure that 
+ * casting is the right thing, but 32-bit UML can't have 64-bit virtual 
+ * addresses 
+ */
+#define __pa(virt) to_phys((void *) (unsigned long) virt)
 #define __va(phys) to_virt((unsigned long) phys)
 
 #define page_to_pfn(page) ((page) - mem_map)



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
