Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAYel-0001oQ-5u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 13:58:31 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAYek-0008JD-Q1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 13:58:31 -0700
Message-Id: <200608082058.k78KwJpx006536@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 08 Aug 2006 16:58:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/2] UML - use ptrace-abi.h instead of ptrace.h
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
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Kyle Moffett <mrmacman_g4@mac.com>

Include the host architecture's ptrace-abi.h instead of ptrace.h.

There was some cpp mangling of names around the ptrace.h include to
avoid symbol clashes between UML and the host architecture.  Most of
these can go away.  The exception is struct pt_regs, which is
convenient to have in userspace, but must be renamed in order that UML
can define its own.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-generic.h	2006-08-06 14:51:28.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-generic.h	2006-08-06 20:35:20.000000000 -0400
@@ -8,18 +8,9 @@
 
 #ifndef __ASSEMBLY__
 
-
 #define pt_regs pt_regs_subarch
-#define show_regs show_regs_subarch
-#define send_sigtrap send_sigtrap_subarch
-
-#include "asm/arch/ptrace.h"
-
+#include "asm/arch/ptrace-abi.h"
 #undef pt_regs
-#undef show_regs
-#undef send_sigtrap
-#undef user_mode
-#undef instruction_pointer
 
 #include "sysdep/ptrace.h"
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
