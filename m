Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNDI-0000yw-O6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:40 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzNDI-0002LK-Dr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:41 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118235522.4626.2825.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus
	error messages
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
Date: Thu, 19 Jan 2006 00:55:23 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Olaf Hering <olh@suse.de>

Olaf reported UML doesn't build for him with a clear analisys of what happened -
we're using NR_CPUS in files linked against glibc headers. Seems like it defines
CONFIG_SMP but not CONFIG_NR_CPUS, so we get CONFIG_NR_CPUS undeclared.

The fix is to move the declaration away from that header file and move it in
asm-um headers, and to add that header where needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h |    2 --
 arch/um/kernel/reboot.c     |    1 +
 include/asm-um/smp.h        |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index c649108..07176d9 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -31,8 +31,6 @@ extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
 
-extern struct task_struct *idle_threads[NR_CPUS];
-
 #define UML_ROUND_DOWN(addr) ((void *)(((unsigned long) addr) & PAGE_MASK))
 #define UML_ROUND_UP(addr) \
 	UML_ROUND_DOWN(((unsigned long) addr) + PAGE_SIZE - 1)
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 6f1a3a2..3ef73bf 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -5,6 +5,7 @@
 
 #include "linux/module.h"
 #include "linux/sched.h"
+#include "asm/smp.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
diff --git a/include/asm-um/smp.h b/include/asm-um/smp.h
index d879eba..aeda665 100644
--- a/include/asm-um/smp.h
+++ b/include/asm-um/smp.h
@@ -23,6 +23,8 @@ extern inline void smp_cpus_done(unsigne
 {
 }
 
+extern struct task_struct *idle_threads[NR_CPUS];
+
 #endif
 
 #endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
