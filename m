Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqZje-0004OI-4f for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 08:28:10 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CqZjd-0000OX-KX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 08:28:10 -0800
Message-Id: <200501171628.j0HGS5h11059@trolli.pdb.fsc.net>
From: bstroesser@fujitsu-siemens.com
Subject: [uml-devel] [patch 1/1] UML: skas3 doesn't need to reserve stub-pages
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
Date: Mon, 17 Jan 2005 17:28:05 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In skas3, the stub-pages for skas0 are unused. Thus, the
space for the stub needs not to be reserved.
So, in skas3 user's stack should may start at 0xc0000000,
as it has been before skas0-implementation.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/kernel/skas/mem.c~skas3-no-stub arch/um/kernel/skas/mem.c
--- linux-2.6.10-mm3/arch/um/kernel/skas/mem.c~skas3-no-stub	2005-01-17 16:02:35.304182317 +0100
+++ linux-2.6.10-mm3-root/arch/um/kernel/skas/mem.c	2005-01-17 16:04:42.625723895 +0100
@@ -7,6 +7,8 @@
 #include "linux/mm.h"
 #include "mem_user.h"
 
+extern int proc_mm, ptrace_faultinfo;
+
 unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out, 
 				  unsigned long *task_size_out)
 {
@@ -18,7 +20,10 @@ unsigned long set_task_sizes_skas(int ar
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
 	*host_size_out = top;
-	*task_size_out = CONFIG_STUB_START;
+	if (proc_mm && ptrace_faultinfo)
+		*task_size_out = top;
+	else
+		*task_size_out = CONFIG_STUB_START;
 #endif
 	return(((unsigned long) set_task_sizes_skas) & ~0xffffff);
 }
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
