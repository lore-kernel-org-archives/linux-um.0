Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zKgt-00078a-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 11:36:43 -0700
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zKgs-00044l-VG
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 11:36:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it>
In-Reply-To: <200309131820.45833.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JY1Z/ASpVgDlYwv"
Message-Id: <200309162027.22242.blaisorblade_spam@yahoo.it>
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
Date: Tue, 16 Sep 2003 20:27:21 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_JY1Z/ASpVgDlYwv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I have finally some working code. I've cleaned it up and it works quite 
well, now I only need to setup the file handling. Also, it can be configured 
with CONFIG_MCONSOLE_EXEC. Note that if disabled, for header issues, it 
defines the exec command anyway but it pretends not to exist(and is not 
showed in the 
However, there is a problem I'm investigating on. Even if the execve fails, it 
reports success. I've debugged it and it showed up that threads synchronize 
properly(i.e. CLONE_VFORK works) and that the fault seems to be in 
kmod.c:exec_usermodehelper.

It seems that this code, at the end of the function:
        if (execve(program_path, argv, envp) < 0)
                return -errno;
        return 0;

is wrong. Execve returns -2(i.e. -ENOENT), but I've not found a place where 
errno is set. It seems that it's not a UML problem, either: simply that code 
should be:
	return execve(program_path, argv, envp);
because kernel functions don't set errno. However I need confirms on this.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_JY1Z/ASpVgDlYwv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mconsole_exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mconsole_exec.patch"

--- linuxUm/arch/um/drivers/mconsole_user.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm/arch/um/drivers/mconsole_user.c	2003-09-16 18:01:24.000000000 +0200
@@ -21,6 +21,7 @@
 	{ "version", mconsole_version, MCONSOLE_INTR },
 	{ "halt", mconsole_halt, MCONSOLE_PROC },
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
+        { "exec", mconsole_exec, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },
 	{ "remove", mconsole_remove, MCONSOLE_PROC },
 	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
--- linuxUm/arch/um/drivers/mconsole_kern.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm/arch/um/drivers/mconsole_kern.c	2003-09-16 19:08:14.000000000 +0200
@@ -18,6 +18,7 @@
 #include "linux/file.h"
 #include "linux/fs.h"
 #include "linux/proc_fs.h"
+#include "linux/kmod.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -203,13 +204,19 @@
 	/* put_filesystem(proc); */
  out: ;
 }
+#ifdef CONFIG_MCONSOLE_EXEC
+#  define EXEC_HELPTEXT "\
+    exec - execute a command as root inside the UML\n"
+#else
+#  define EXEC_HELPTEXT ""
+#endif
 
 #define UML_MCONSOLE_HELPTEXT \
 "Commands: \n\
     version - Get kernel version \n\
     help - Print this message \n\
     halt - Halt UML \n\
-    reboot - Reboot UML \n\
+    reboot - Reboot UML \n" EXEC_HELPTEXT "\
     config <dev>=<config> - Add a new device to UML;  \n\
 	same syntax as command line \n\
     config <dev> - Query the configuration of a device \n\
@@ -265,6 +272,149 @@
 	reactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	mconsole_reply(req, "", 0, 0);
 }
+#ifdef CONFIG_MCONSOLE_EXEC
+/* This is the focal point of the exec patch. Much code comes from
+ * kernel/kmod.c. But I just couldn't use call_usermodehelper, because it must be 
+ * called from process context.*/
+struct subprocess_info {
+	char *command;
+	int retval;
+};
+
+/* This function parses arguments from buf to the argv array.
+ * When it goes on a space, starts a new arguments. If it starts with a quote,
+ * it will end at the first matching quote(of the same tipe) which is not escaped with a \.
+ * Otherwise, the arg ends at the first space and can freely contain quotes.
+ * After this, in each argument \<char> is replaced by char.*/
+static void parse_args(char *buf, size_t size, char **argv) {
+	char *start_arg = buf, *end_arg;
+	int i = 0, must_not_break = 1;
+
+	start_arg += strlen("exec");
+
+	while (i < size - 1 && must_not_break) {
+		while(isspace(*start_arg))
+			start_arg++;
+
+		if (*start_arg == '\0')
+			break;
+
+		end_arg = start_arg;
+		if (*start_arg == '\"' || *start_arg == '\'') { /*quoted arg*/
+			end_arg++;
+			/*while (1) {
+				while (*end_arg != *start_arg && *end_arg != '\0')
+					end_arg++;
+				if (*(end_arg - 1) != '\\' || *end_arg == '\0')
+					break;
+				end_arg++;
+			}*/
+			while ((*end_arg != *start_arg || *(end_arg - 1) == '\\')
+				&& *end_arg != '\0')
+				end_arg++;
+			start_arg++;	/*skips the first quote*/
+		} else {
+			while(!isspace(*end_arg) && *end_arg != '\0')
+				end_arg++;
+		}
+		argv[i++] = start_arg;
+
+		if (*end_arg == '\0')
+			must_not_break = 0; /*we have finished, but the break must
+					      be done after we strip '\' out.*/
+		*end_arg = '\0';
+
+		/*let's remove those '\'! The text is shifted back to cover the \'s*/
+		char *curs = start_arg;
+		int displacement = 0;
+		while (*curs != '\\' && *curs != '\0')
+			curs++;
+		while (*curs != '\0') {
+			displacement++;
+			curs++;
+			do {
+				*(curs-displacement) = *curs;
+				curs++;
+			} while (*curs != '\\' && *curs != '\0');
+		}
+		*(curs - displacement) = '\0';
+		start_arg = end_arg + 1;
+	}
+
+	argv[i] = NULL;
+}
+
+/* This code must be called in a new thread, and uses 2.4 exec_usermodehelper
+ * (which seems to be gone inside 2.6) to start the specified program.
+ * This function is like ____call_usermodehelper*/
+static int runner_thread(void * data)
+{
+	struct subprocess_info *sub_info = data;
+
+	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
+
+	char *path, *argv[MCONSOLE_MAX_DATA / 2 + 1];
+	char buf[MCONSOLE_MAX_DATA];
+	int retval;
+
+	strcpy(buf, sub_info->command);
+
+	parse_args(buf, MCONSOLE_MAX_DATA / 2 + 1, argv);
+	if (*argv[0] == '\0')
+		sub_info->retval = -EINVAL; /*invalid command to execute, though this maybe 
+					      is not needed.*/
+	path = argv[0];
+
+	retval = exec_usermodehelper(path, argv, envp);
+
+	/* Exec failed? */
+	sub_info->retval = retval;
+	do_exit(0);
+}
+
+/* This is like __call_usermodehelper. Only exception is that it's not a callback of keventd, and that 
+ * it bundles the declaration of sub_info from call_usermodehelper.*/
+void mconsole_exec(struct mc_request *req)
+{
+	pid_t pid;
+
+	struct subprocess_info sub_info = {
+		command:	req->request.data,
+		retval:		0,
+	};
+
+	/*
+	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
+	 * We need the data structures to stay around until that is done.
+	 */
+	pid = kernel_thread(runner_thread, &sub_info, CLONE_VFORK | SIGCHLD);
+
+	if (pid < 0) {
+		char buf[60];
+		snprintf(buf, 60, "kernel_thread failed in mconsole_exec with error code: %d", -pid);
+		mconsole_reply(req, buf, 1, 0);
+		return;
+	}
+	if (sub_info.retval < 0) {
+		char buf[50];
+		snprintf(buf, 50, "execve failed in mconsole_exec with errno = %d", -sub_info.retval);
+		mconsole_reply(req, buf, 1, 0);
+		return;
+	}
+
+	mconsole_reply(req, "The command has been started successfully.", 0, 0);
+}
+#else
+/* I must put mconsole_exec in the commands table always, because there 
+ * linux/config.h cannot be included. So I pretend it doesn't exist by hiding
+ * it in the help text*/
+void mconsole_exec(struct mc_request *req)
+{
+	mconsole_reply(req, "Unknown command", 1, 0);
+	/*must be the same as in mconsole_reply*/
+}
+/* Patch end */
+#endif			/*CONFIG_MCONSOLE_EXEC*/
 
 /* This list is populated by __initcall routines. */
 
--- linuxUm/arch/um/config.in.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm/arch/um/config.in	2003-09-16 16:31:13.000000000 +0200
@@ -40,6 +40,7 @@
 tristate 'Host filesystem' CONFIG_HOSTFS
 tristate 'Honeypot proc filesystem' CONFIG_HPPFS
 bool 'Management console' CONFIG_MCONSOLE
+dep_bool 'Execution through management console' CONFIG_MCONSOLE_EXEC $CONFIG_MCONSOLE
 dep_bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_MCONSOLE
 bool '2G/2G host address space split' CONFIG_HOST_2G_2G
 bool 'Symmetric multi-processing support' CONFIG_UML_SMP
--- linuxUm/arch/um/include/mconsole.h.saved	2003-09-13 20:22:07.000000000 +0200
+++ linuxUm/arch/um/include/mconsole.h	2003-09-16 18:11:48.000000000 +0200
@@ -73,6 +73,7 @@
 extern void mconsole_help(struct mc_request *req);
 extern void mconsole_halt(struct mc_request *req);
 extern void mconsole_reboot(struct mc_request *req);
+extern void mconsole_exec(struct mc_request *req);
 extern void mconsole_config(struct mc_request *req);
 extern void mconsole_remove(struct mc_request *req);
 extern void mconsole_sysrq(struct mc_request *req);

--Boundary-00=_JY1Z/ASpVgDlYwv--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
