Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdGdl-0000WW-UG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jan 2004 14:22:33 -0800
Received: from dimitri1.net1.nerim.net ([62.212.102.53] helo=sengena.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AdE9Q-0004AE-Qs
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jan 2004 11:43:05 -0800
Received: from localhost ([127.0.0.1] helo=support.sengena.com)
	by sengena.com with smtp (Exim 4.22) id 1AdE9K-0002Wg-TD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jan 2004 20:42:58 +0100
Message-ID: <45750.192.168.1.2.1073245378.squirrel@support.sengena.com>
From: "Nicolas Dimitrijevic" <uml-nicospam@sengena.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040104204258_49058"
Subject: [uml-devel] 2.6.0 ldt_modify and ptrace fix
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
Date: Sun, 4 Jan 2004 20:42:58 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net


------=_20040104204258_49058
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

Here is two patch (build on Ingo-A7 patch), they should fix compilation
problems on any kernel headers version installed.

nicod



------=_20040104204258_49058
Content-Type: text/plain; name="ldt.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ldt.diff"

--- linux-2.6.0/arch/um/sys-i386/bugs.c	2004-01-04 18:13:52.000000000 +0100
+++ linux-2.6.0-uml/arch/um/sys-i386/bugs.c	2004-01-04 19:32:44.000000000 +0100
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <sys/signal.h>
 #include <asm/ldt.h>
+#include <linux/version.h>
 #include "kern_util.h"
 #include "user.h"
 #include "sysdep/ptrace.h"
@@ -107,7 +108,11 @@
 
 static void disable_lcall(void)
 {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,32)
+	struct user_desc ldt;
+#else
 	struct modify_ldt_ldt_s ldt;
+#endif
 	int err;
 
 	bzero(&ldt, sizeof(ldt));
------=_20040104204258_49058
Content-Type: text/plain; name="ptrace.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ptrace.diff"

--- linux-2.6.0/arch/um/sys-i386/ptrace_user.c	2003-12-18 03:58:28.000000000 +0100
+++ linux-2.6.0-uml/arch/um/sys-i386/ptrace_user.c	2004-01-04 19:54:21.000000000 +0100
@@ -8,7 +8,12 @@
 #include <unistd.h>
 #include <linux/stddef.h>
 #include <sys/ptrace.h>
-#include <asm/ptrace.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
+# include <linux/ptrace.h>
+#else
+# include <asm/ptrace.h>
+#endif
 #include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
------=_20040104204258_49058--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
