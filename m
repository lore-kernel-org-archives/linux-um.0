Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ybvN-0004e6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 11:48:41 -0700
Received: from smtp014.mail.yahoo.com ([216.136.173.58])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19ybvM-0005Td-Au
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 11:48:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <20030913194849.GX8622@alcor.net>
In-Reply-To: <20030913194849.GX8622@alcor.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bhLZ/+ZuU5QxIRr"
Message-Id: <200309142050.03304.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 Sep 2003 20:50:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_bhLZ/+ZuU5QxIRr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alle 21:48, sabato 13 settembre 2003, Matt Zimmerman ha scritto:
> On Sat, Sep 13, 2003 at 06:20:45PM +0200, BlaisorBlade wrote:
> >
> > I'd like a discussion about this(how much interest in this there is,
> > suggestions, requests). Especially:
>
> This is interesting.  I wrote a small client/server system for the purpose
> of programmatically executing programs within UML.  It works nicely, with
> the exception that it is necessary to install the server within UML in
> order for it to work.  It would be nice to be able to do this with a
> pristine UML.
>
> What do you do with stdin, stdout and stderr?  I connect them to a UML
> serial device, which can be connected to the tty (for interactive programs)
> or any other UML channel.
Hmm, I didn't think to this. I was thinking to *simple* commands, only a bit 
more complicate than the cad one, such as calling mount(I thought to the 
->"Add shared directory" VMWare menu item...). Also, this is my first "true" 
kernel work, and I took most of the code from kernel/kmod.c, i.e. the one 
which runs modprobe/hotplug.

Your idea is good(opening a file and dupping it to 0,1,2 handles should be 
simple). Only I wouldn't like that it becomes too long to implement, i.e. to 
do in user-space. And I must go discovering how exactly to do it inside the 
kernel(I'll do this, however).
>
> > - is the ability to read arguments with spaces(within quotes) needed even
> > for the program name?
>
> I don't think this is particularly crucial; does it cause some unexpected
> difficulty?
No, simply I hadn't wrote the code yet and at first I thought that this was 
useless(because the program path wouldn't normally contain spaces).

Now, I'm posting the patch against 2.4.22-3um(I am not so fast to port patches 
back and forth to reach -4um for now). It does compile, I've got to test the 
parsing part but I want to post it even now so that you can say me if I'm 
doing it well or using a completely wrong way, and such things(I'm new to 
kernel hacking, as I said, even if I found enough docs).

I already know that the limit to 20 args is ugly; it's only a fast crap I put 
there, even because I had doubt about calling kmalloc. What I understood,at 
the end, is that I can call it freely in runner_thread(with GFP_KERNEL and 
without GFP_ATOMIC) and that I must free it only if execve(which is wrapped 
inside exec_usermodehelper, see kernel/kmod.c) fails. Is it right?

Thanks for the interest, and sorry if you think you wasted your time.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_bhLZ/+ZuU5QxIRr
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mconsole_exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="mconsole_exec.patch"

--- linuxUm-2.4.22/arch/um/drivers/mconsole_user.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm-2.4.22/arch/um/drivers/mconsole_user.c	2003-09-14 18:15:13.000000000 +0200
@@ -21,6 +21,7 @@
 	{ "version", mconsole_version, MCONSOLE_INTR },
 	{ "halt", mconsole_halt, MCONSOLE_PROC },
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
+        { "exec", mconsole_exec, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },
 	{ "remove", mconsole_remove, MCONSOLE_PROC },
 	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
--- linuxUm-2.4.22/arch/um/drivers/mconsole_kern.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm-2.4.22/arch/um/drivers/mconsole_kern.c	2003-09-14 20:27:00.000000000 +0200
@@ -18,6 +18,7 @@
 #include "linux/file.h"
 #include "linux/fs.h"
 #include "linux/proc_fs.h"
+#include "linux/kmod.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -210,6 +211,7 @@
     help - Print this message \n\
     halt - Halt UML \n\
     reboot - Reboot UML \n\
+    exec - execute a command as root inside the UML\n\
     config <dev>=<config> - Add a new device to UML;  \n\
 	same syntax as command line \n\
     config <dev> - Query the configuration of a device \n\
@@ -266,6 +268,95 @@
 	mconsole_reply(req, "", 0, 0);
 }
 
+/* This is the focal point of the exec patch. Much code comes from
+ * kernel/kmod.c. But I just couldn't use call_usermodehelper, because it must be 
+ * called from process context.*/
+struct subprocess_info {
+        char *command;
+        pid_t retval;
+};
+
+/* This code must be called in a new thread, and uses 2.4 exec_usermodehelper
+ * (which seems to be gone inside 2.6) to start the specified program.
+ * This function is like ____call_usermodehelper*/
+int runner_thread(void * data)
+{
+        struct subprocess_info *sub_info = data;
+	char buf[MCONSOLE_MAX_DATA];
+        char *ptr = buf, *endptr;
+        char *path, *argv[21]; /*For now.*/
+	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
+	int i = 0, retval;
+	strcpy(buf, sub_info->command);
+
+	ptr += strlen("exec");
+
+	while (i < 20) {
+		while(isspace(*ptr)) ptr++;
+
+		if (ptr == NULL)
+			break;
+
+		endptr = ptr;
+		if (*ptr == '\"' || *ptr == '\'') { /*quoted arg*/
+			while (*endptr != *ptr || *(endptr - 1) == '\\') endptr++;
+			ptr++;  /*skips the first quote*/
+		} else {
+			while(!isspace(*endptr)) endptr++;
+		}
+		argv[i++] = ptr;
+		*endptr = '\0';
+		ptr = endptr + 1;
+	}
+
+	if (*argv[0] == '\0')
+		sub_info->retval = -EINVAL; /*invalid command to execute, though this maybe 
+					      is not needed.*/
+	path = argv[0];
+	argv[i] = NULL;
+
+	/*path = "/bin/sleep";
+        argv = { path, "20", NULL };*/
+        retval = exec_usermodehelper(path, argv, envp);
+
+        /* Exec failed? */
+        sub_info->retval = (pid_t)retval;
+        do_exit(0);
+}
+
+/* This is like __call_usermodehelper. Only exception is that it's not a callback of keventd, and that 
+ * it bundles the declaration of sub_info from call_usermodehelper.*/
+void mconsole_exec(struct mc_request *req)
+{
+        pid_t pid;
+
+        struct subprocess_info sub_info = {
+                command:        req->request.data,
+                retval:         0,
+        };
+
+        /*
+         * CLONE_VFORK: wait until the usermode helper has execve'd successfully
+         * We need the data structures to stay around until that is done.
+         */
+        pid = kernel_thread(runner_thread, &sub_info, CLONE_VFORK | SIGCHLD);
+
+	if (pid < 0) {
+		char buf[60];
+		snprintf(buf, 60, "kernel_thread failed in mconsole_exec with error code: %d", -pid);
+		mconsole_reply(req, buf, 1, 0);
+	}
+	if (sub_info.retval < 0) {
+		char buf[50];
+		snprintf(buf, 50, "execve failed in mconsole_exec with errno = %d", -sub_info.retval);
+		mconsole_reply(req, buf, 1, 0);
+	}
+
+	mconsole_reply(req, "The command has been started successfully.", 0, 0);
+}
+
+/* Patch end */
+
 /* This list is populated by __initcall routines. */
 
 LIST_HEAD(mconsole_devices);
--- linuxUm-2.4.22/arch/um/include/mconsole.h.saved	2003-09-13 20:22:07.000000000 +0200
+++ linuxUm-2.4.22/arch/um/include/mconsole.h	2003-09-14 12:19:53.000000000 +0200
@@ -73,6 +73,7 @@
 extern void mconsole_help(struct mc_request *req);
 extern void mconsole_halt(struct mc_request *req);
 extern void mconsole_reboot(struct mc_request *req);
+extern void mconsole_exec(struct mc_request *req);
 extern void mconsole_config(struct mc_request *req);
 extern void mconsole_remove(struct mc_request *req);
 extern void mconsole_sysrq(struct mc_request *req);

--Boundary-00=_bhLZ/+ZuU5QxIRr--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
