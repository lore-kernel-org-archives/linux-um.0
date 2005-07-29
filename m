Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyWe4-0004CK-Oi	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jul 2005 08:19:32 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DyWe3-0006fB-AI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jul 2005 08:19:32 -0700
Message-Id: <200507291513.j6TFDEml008056@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Fix vsyscall brokenness
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
Date: Fri, 29 Jul 2005 11:13:13 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The #if/#ifdef cleanup exposed a bug in UML's ELF header processing.  With 
this bug fixed, UML recognizes the vsyscall info coming from the host.  On
FC4, there is a vsyscall page low in the address space, which UML doesn't
provide.  This causes an infinite page fault loop and a hang on boot.

This patch works around that by making this look like a no-vsyscall system.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/os-Linux/elf_aux.c	2005-07-28 12:08:54.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/os-Linux/elf_aux.c	2005-07-28 18:47:31.000000000 -0400
@@ -9,9 +9,10 @@
  */
 #include <elf.h>
 #include <stddef.h>
+#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
-#include <asm/elf.h>
+#include "mem_user.h"
 
 #if ELF_CLASS == ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
@@ -41,6 +42,9 @@
 				break;
 			case AT_SYSINFO_EHDR:
 				vsyscall_ehdr = auxv->a_un.a_val;
+				/* See if the page is under TASK_SIZE */
+				if (vsyscall_ehdr < (unsigned long) envp) 
+					vsyscall_ehdr = 0;
 				break;
 			case AT_HWCAP:
 				elf_aux_hwcap = auxv->a_un.a_val;



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
