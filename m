Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iI-00049S-G9	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:58 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iI-0001IU-1q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:58 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172835.10219.94895.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 04/10] uml: fix hang in TT mode on fault
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
Date: Wed, 21 Sep 2005 19:28:36 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current code doesn't handle well general protection faults on the host - it
thinks that cr2 is always the address of a page fault. While actually, on
general protection faults, that address is not accessible, so we'd better assume
we couldn't satisfy the fault. Currently instead we think we've fixed it, so we
go back, retry the instruction and fault again endlessly.

This leads to the kernel hanging when doing copy_from_user(dest, -1, ...) in TT
mode, since reading *(-1) causes a GFP, and we don't support kernel preemption.

Thanks to Luo Xin for testing UML with LTP and reporting the failures he got.

Cc: Luo Xin <luothing@sina.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c       |   11 ++++++++++-
 arch/um/kernel/tt/uaccess_user.c |   11 +++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -18,6 +18,7 @@
 #include "asm/a.out.h"
 #include "asm/current.h"
 #include "asm/irq.h"
+#include "sysdep/sigcontext.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
@@ -125,7 +126,15 @@ unsigned long segv(struct faultinfo fi, 
         }
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
-	err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+	else {
+		err = -EFAULT;
+		/* A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode. */
+		address = 0;
+	}
 
 	catcher = current->thread.fault_catcher;
 	if(!err)
diff --git a/arch/um/kernel/tt/uaccess_user.c b/arch/um/kernel/tt/uaccess_user.c
--- a/arch/um/kernel/tt/uaccess_user.c
+++ b/arch/um/kernel/tt/uaccess_user.c
@@ -22,8 +22,15 @@ int __do_copy_from_user(void *to, const 
 			       __do_copy, &faulted);
 	TASK_REGS(get_current())->tt = save;
 
-	if(!faulted) return(0);
-	else return(n - (fault - (unsigned long) from));
+	if(!faulted)
+		return 0;
+	else if (fault)
+		return n - (fault - (unsigned long) from);
+	else
+		/* In case of a general protection fault, we don't have the
+		 * fault address, so NULL is used instead. Pretend we didn't
+		 * copy anything. */
+		return n;
 }
 
 static void __do_strncpy(void *dst, const void *src, int count)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
