Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bni0C-0001zv-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:09:08 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bni0C-0006El-92 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:09:08 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yT9/A5PX9Z0aCIE"
Message-Id: <200407221653.38293.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] Mconsole exec support - rewritten completely
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
Date: Thu, 22 Jul 2004 16:53:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_yT9/A5PX9Z0aCIE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a new version (much lighter) of the mconsole exec support.

I.e., from mconsole, you run "exec <whatever>" and inside the UML, the kernel 
will start /bin/sh -c "<whatever>"; I especially recommend using 
redirections. It is nice to do something like "exec exec /bin/bash <> 
/dev/tty2" to open a new temp console as root (adjust the command as needed).

This time, it simply exec "/bin/sh -c" with the right arguments, so it's much 
safer than the old version of one year ago. Jeff, you can still think that 
this feature should not be in the kernel support (but why then bother with 
the "proc" command?), even if this time there is no more any parsing code; 
but anyway, it will stay available for who wants it.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_yT9/A5PX9Z0aCIE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mconsole_exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mconsole_exec.patch"



Adds the "exec" command to mconsole; the command is passed to /bin/sh -c, so
you know its syntax. It uses call_usermodehelper.


---

 uml-linux-2.6.7-paolo/arch/um/Kconfig                 |    9 +++++
 uml-linux-2.6.7-paolo/arch/um/drivers/mconsole_kern.c |   32 +++++++++++++++++-
 uml-linux-2.6.7-paolo/arch/um/drivers/mconsole_user.c |    4 ++
 uml-linux-2.6.7-paolo/arch/um/include/mconsole.h      |    1 
 4 files changed, 45 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/mconsole_kern.c~mconsole_exec arch/um/drivers/mconsole_kern.c
--- uml-linux-2.6.7/arch/um/drivers/mconsole_kern.c~mconsole_exec	2004-06-21 16:54:17.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/mconsole_kern.c	2004-06-21 16:54:17.000000000 +0200
@@ -19,6 +19,7 @@
 #include "linux/fs.h"
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
+#include "linux/kmod.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -118,6 +119,27 @@ void mconsole_log(struct mc_request *req
 	mconsole_reply(req, "", 0, 0);
 }
 
+
+#ifdef CONFIG_MCONSOLE_EXEC
+void mconsole_exec(struct mc_request *req)
+{
+	int res;
+
+	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
+	char *argv[] = { "/bin/sh", "-c", req->request.data + strlen("exec "), NULL };
+	res = call_usermodehelper("/bin/sh", argv, envp, 0);
+
+	if (res < 0) {
+		char buf[60];
+		snprintf(buf, 60, "call_usermodehelper failed in mconsole_exec with error code: %d", -res);
+		mconsole_reply(req, buf, 1, 0);
+		return;
+	}
+
+	mconsole_reply(req, "The command has been started successfully.", 0, 0);
+}
+#endif
+
 void mconsole_proc(struct mc_request *req)
 {
 	struct nameidata nd;
@@ -193,6 +215,14 @@ void mconsole_proc(struct mc_request *re
  out: ;
 }
 
+#ifdef CONFIG_MCONSOLE_EXEC
+#  define EXEC_HELPTEXT "\
+    exec <command> - runs the specified command through /bin/sh -c\n"
+#else
+#  define EXEC_HELPTEXT ""
+#endif
+
+    /*exec - execute a command as root inside the UML\n"*/
 #define UML_MCONSOLE_HELPTEXT \
 "Commands: \n\
     version - Get kernel version \n\
@@ -207,7 +237,7 @@ void mconsole_proc(struct mc_request *re
     cad - invoke the Ctl-Alt-Del handler \n\
     stop - pause the UML; it will do nothing until it receives a 'go' \n\
     go - continue the UML after a 'stop' \n\
-    log <string> - make UML enter <string> into the kernel log\n\
+    log <string> - make UML enter <string> into the kernel log\n" EXEC_HELPTEXT "\
     proc <file> - returns the contents of the UML's /proc/<file>\n\
 "
 
diff -puN arch/um/drivers/mconsole_user.c~mconsole_exec arch/um/drivers/mconsole_user.c
--- uml-linux-2.6.7/arch/um/drivers/mconsole_user.c~mconsole_exec	2004-06-21 16:54:17.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/mconsole_user.c	2004-06-21 16:54:17.000000000 +0200
@@ -16,6 +16,7 @@
 #include "user.h"
 #include "mconsole.h"
 #include "umid.h"
+#include "uml-config.h"
 
 static struct mconsole_command commands[] = {
 	{ "version", mconsole_version, MCONSOLE_INTR },
@@ -30,6 +31,9 @@ static struct mconsole_command commands[
 	{ "go", mconsole_go, MCONSOLE_INTR },
 	{ "log", mconsole_log, MCONSOLE_INTR },
 	{ "proc", mconsole_proc, MCONSOLE_PROC },
+#ifdef UML_CONFIG_MCONSOLE_EXEC
+	{ "exec", mconsole_exec, MCONSOLE_PROC },
+#endif
 };
 
 /* Initialized in mconsole_init, which is an initcall */
diff -puN arch/um/Kconfig~mconsole_exec arch/um/Kconfig
--- uml-linux-2.6.7/arch/um/Kconfig~mconsole_exec	2004-06-21 16:54:17.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Kconfig	2004-06-21 16:56:00.000000000 +0200
@@ -129,6 +129,15 @@ config MCONSOLE
 
         It is safe to say 'Y' here.
 
+config MCONSOLE_EXEC
+	bool "Management console 'exec' support"
+	depends on MCONSOLE
+	help
+	Adds the 'exec' command to mconsole, which allows execution of arbitrary command
+	inside UML.
+	All its parameters are passed to /bin/sh -c inside UML, so you can use the full
+	shell syntax, especially redirections.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on MCONSOLE
diff -puN arch/um/include/mconsole.h~mconsole_exec arch/um/include/mconsole.h
--- uml-linux-2.6.7/arch/um/include/mconsole.h~mconsole_exec	2004-06-21 16:54:17.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/include/mconsole.h	2004-06-21 16:54:17.000000000 +0200
@@ -80,6 +80,7 @@ extern void mconsole_cad(struct mc_reque
 extern void mconsole_stop(struct mc_request *req);
 extern void mconsole_go(struct mc_request *req);
 extern void mconsole_log(struct mc_request *req);
+extern void mconsole_exec(struct mc_request *req);
 extern void mconsole_proc(struct mc_request *req);
 
 extern int mconsole_get_request(int fd, struct mc_request *req);

_

--Boundary-00=_yT9/A5PX9Z0aCIE--




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
