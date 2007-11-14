Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsNnC-0001pU-Lx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 11:20:54 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsNnC-0000jy-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 11:20:54 -0800
Date: Wed, 14 Nov 2007 14:20:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071114192049.GA9098@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Fix build in 2.6.24-rc2-mm1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

A small set of fixes to make UML build in 2.6.24-rc2-mm1.

A use of KERN_CONT was added to a userspace file, which needed to use
UM_KERN_CONT instead, and a definition of it added to
common-offsets.h.

The earlier pgtable.h tidying patch made things a bit too tidy.  Add
back a header which is needed in VMALLOC_START and friend.  Also add
back a definition of pmd_page_vaddr, which is needed on x86_64.

init.h started breaking now for some reason.  It turns out that there
wasn't a definition of __user.  Fixed this by copying the relevant
stuff from compiler.h in the userspace case, and including compiler.h
in the kernel case.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/common-offsets.h |    1 +
 arch/um/include/init.h           |    9 +++++++++
 arch/um/sys-i386/bugs.c          |    4 ++--
 include/asm-um/pgtable.h         |    2 ++
 4 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/common-offsets.h	2007-11-14 11:28:55.000000000 -0500
+++ linux-2.6.22/arch/um/include/common-offsets.h	2007-11-14 12:58:03.000000000 -0500
@@ -18,6 +18,7 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
+DEFINE_STR(UM_KERN_CONT, KERN_CONT);
 
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
Index: linux-2.6.22/arch/um/sys-i386/bugs.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/bugs.c	2007-11-14 10:34:33.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/bugs.c	2007-11-14 12:05:52.000000000 -0500
@@ -36,9 +36,9 @@ void arch_check_bugs(void)
 	if (setjmp(cmov_test_return) == 0) {
 		unsigned long foo = 0;
 		__asm__ __volatile__("cmovz %0, %1" : "=r" (foo) : "0" (foo));
-		printk(KERN_CONT "Yes\n");
+		printk(UM_KERN_CONT "Yes\n");
 	} else
-		printk(KERN_CONT "No\n");
+		printk(UM_KERN_CONT "No\n");
 
 	sigaction(SIGILL, &old, &new);
 }
Index: linux-2.6.22/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable.h	2007-11-14 11:28:57.000000000 -0500
+++ linux-2.6.22/include/asm-um/pgtable.h	2007-11-14 14:03:45.000000000 -0500
@@ -9,6 +9,7 @@
 #define __UM_PGTABLE_H
 
 #include "linux/sched.h"
+#include <asm/fixmap.h>
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
@@ -308,6 +309,7 @@ static inline pte_t pte_modify(pte_t pte
  * this macro returns the index of the entry in the pmd page which would
  * control the given virtual address
  */
+#define pmd_page_vaddr(pmd) ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /*
Index: linux-2.6.22/arch/um/include/init.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/init.h	2007-11-14 10:34:33.000000000 -0500
+++ linux-2.6.22/arch/um/include/init.h	2007-11-14 12:28:07.000000000 -0500
@@ -40,6 +40,15 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+#ifndef __KERNEL__
+#if __GNUC_MINOR__ >= 3
+# define __used			__attribute__((__used__))
+#else
+# define __used			__attribute__((__unused__))
+#endif
+#else
+#include <linux/compiler.h>
+#endif
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__attribute__ ((__section__ (".init.text")))

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
