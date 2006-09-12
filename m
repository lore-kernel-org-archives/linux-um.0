Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNAa6-0004ct-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 08:53:51 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GNAa5-0008JT-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 08:53:51 -0700
Message-Id: <200609121552.k8CFqDcJ008012@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 12 Sep 2006 11:52:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/2] Make UML use ptrace-abi.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: zach@vmware.com, jeremy@xensource.com, user-mode-linux-devel@lists.sourceforge.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de, 76306.1226@compuserve.com

Include the host architecture's ptrace-abi.h instead of ptrace.h.

There was some cpp mangling of names around the ptrace.h include to
avoid symbol clashes between UML and the host architecture.  Most of
these can go away.  The exception is struct pt_regs, which is
convenient to have in userspace, but must be renamed in order that UML
can define its own.

ptrace-x86_64.h needed to have some now-obsolete cpp cruft and a declaration
removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-generic.h	2006-09-12 11:09:26.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-generic.h	2006-09-12 11:17:23.000000000 -0400
@@ -8,19 +8,7 @@
 
 #ifndef __ASSEMBLY__
 
-
-#define pt_regs pt_regs_subarch
-#define show_regs show_regs_subarch
-#define send_sigtrap send_sigtrap_subarch
-
-#include "asm/arch/ptrace.h"
-
-#undef pt_regs
-#undef show_regs
-#undef send_sigtrap
-#undef user_mode
-#undef instruction_pointer
-
+#include "asm/arch/ptrace-abi.h"
 #include "sysdep/ptrace.h"
 
 struct pt_regs {
Index: linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-x86_64.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h	2006-09-12 11:43:41.000000000 -0400
@@ -11,15 +11,11 @@
 #include "asm/errno.h"
 #include "asm/host_ldt.h"
 
-#define signal_fault signal_fault_x86_64
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
 #include "asm/ptrace-generic.h"
-#undef signal_fault
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
 
-void signal_fault(struct pt_regs_subarch *regs, void *frame, char *where);
-
 #define FS_BASE (21 * sizeof(unsigned long))
 #define GS_BASE (22 * sizeof(unsigned long))
 #define DS (23 * sizeof(unsigned long))


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
