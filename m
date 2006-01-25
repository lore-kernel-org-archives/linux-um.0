Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1geJ-0000Fa-Ok for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 01:09:07 -0800
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F1geI-00074Q-Al
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 01:09:07 -0800
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0601251105120.23552@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] um: fix compliation error when CONFIG_SKAS is
	disabled
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
Date: Wed, 25 Jan 2006 11:08:27 +0200 (EET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch fixes the following compilation error when CONFIG_SKAS is disabled:

  CC      arch/um/sys-i386/ldt.o
arch/um/sys-i386/ldt.c:19:21: proc_mm.h: No such file or directory
make[1]: *** [arch/um/sys-i386/ldt.o] Error 1

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

Index: 2.6/arch/um/sys-i386/ldt.c
===================================================================
--- 2.6.orig/arch/um/sys-i386/ldt.c
+++ 2.6/arch/um/sys-i386/ldt.c
@@ -16,7 +16,6 @@
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
-#include "proc_mm.h"
 #include "os.h"
 
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
@@ -90,6 +89,7 @@ out:
 #include "skas.h"
 #include "skas_ptrace.h"
 #include "asm/mmu_context.h"
+#include "proc_mm.h"
 
 long write_ldt_entry(struct mm_id * mm_idp, int func, struct user_desc * desc,
 		     void **addr, int done)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
