Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVa2t-00014j-1r for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 11:00:59 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BVa2r-0006hC-Se for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 11:00:58 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] best way for init-script to start/stop
	UML
References: <c7aquk$trh$1@sea.gmane.org>
	<032901c43dee$7da4a730$2000000a@schlepptopp>
	<40ABF713.6000504@upb.de>
In-Reply-To: <40ABF713.6000504@upb.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KdbvAEkAzpX6H7S"
Message-Id: <200406021317.30409.blaisorblade_spam@yahoo.it>
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
Date: Wed, 2 Jun 2004 13:17:30 +0200
To: Sven =?iso-8859-15?q?K=F6hler?= <skoehler@upb.de>, roland <for_spam@gmx.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_KdbvAEkAzpX6H7S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 02:08, gioved=EC 20 maggio 2004, Sven K=F6hler ha scritto:
> > imho, it should be possible to issue init-commands to a running uml via
> > uml_mconsole, to switch uml guest systems to whatever init-level we lik=
e.
> > is such feature existing or being planned ?

A lot of time ago I implemented (not in a very good way probably) a patch,=
=20
which worked, to execute via Mconsole any command inside UML. It is attache=
d.=20
It is old, ugly and very bad. However, it's already published.

It has no support for console I/O to the command, so it's just a bit of a=20
generalization to your request (think of modprobe, for instance). I planned=
 a=20
big change which could make it easier: at that time I wrote an ugly parsing=
=20
routine to split the command line in the argv[] array; after that I thought=
=20
that I could pass it to bash:

char *argv[] =3D {"/bin/sh", "-c", passedString};

exec_usermodehelper(3, argv, envp); /*a wrapper of execve which is normally=
=20
used to call modprobe when needed*/

but I never implemented this, which could also allow a big simplification o=
f=20
the patch. This solution would allow I/O, if you use a redirection on the=20
mconsole command line!

Btw: I didn't know at that time I could include uml-config.h and do #ifdef=
=20
UML_CONFIG_MCONSOLE_EXEC. So I did another hack for this.

> That would be a good if not the best sollution. Are there any distos
> that don't use init? i don't think so (having that said, i should better
> check gentoo, cause it has a different run-level concept etc.).

Any distro uses init, but Slackware uses a BSD init by default (so that=20
runlevels are meaningless except for what is specified inside /etc/inittab)=
,=20
Debian uses to run on runlevel 2 (IIRC, never used Debian: stable is old an=
d=20
unstable needs fast Internet connection + lot of braveness).

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_KdbvAEkAzpX6H7S
Content-Type: text/x-diff; charset="iso-8859-1"; name="mconsole_exec-04.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mconsole_exec-04.patch"

--- linuxUm-2.4.22/arch/um/drivers/mconsole_user.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm-2.4.22/arch/um/drivers/mconsole_user.c	2003-09-16 18:01:24.000000000 +0200
@@ -21,6 +21,7 @@
 	{ "version", mconsole_version, MCONSOLE_INTR },
 	{ "halt", mconsole_halt, MCONSOLE_PROC },
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
+        { "exec", mconsole_exec, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },
 	{ "remove", mconsole_remove, MCONSOLE_PROC },
 	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
--- linuxUm-2.4.22/arch/um/drivers/mconsole_kern.c.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm-2.4.22/arch/um/drivers/mconsole_kern.c	2003-09-16 18:10:21.000000000 +0200
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
@@ -265,6 +272,150 @@
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
+	path = argv[0];
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
 
--- linuxUm-2.4.22/arch/um/config.in.saved	2003-09-13 20:22:06.000000000 +0200
+++ linuxUm-2.4.22/arch/um/config.in	2003-09-16 16:31:13.000000000 +0200
@@ -40,6 +40,7 @@
 tristate 'Host filesystem' CONFIG_HOSTFS
 tristate 'Honeypot proc filesystem' CONFIG_HPPFS
 bool 'Management console' CONFIG_MCONSOLE
+dep_bool 'Execution through management console' CONFIG_MCONSOLE_EXEC $CONFIG_MCONSOLE
 dep_bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_MCONSOLE
 bool '2G/2G host address space split' CONFIG_HOST_2G_2G
 bool 'Symmetric multi-processing support' CONFIG_UML_SMP
--- linuxUm-2.4.22/arch/um/include/mconsole.h.saved	2003-09-13 20:22:07.000000000 +0200
+++ linuxUm-2.4.22/arch/um/include/mconsole.h	2003-09-16 18:11:48.000000000 +0200
@@ -73,6 +73,7 @@
 extern void mconsole_help(struct mc_request *req);
 extern void mconsole_halt(struct mc_request *req);
 extern void mconsole_reboot(struct mc_request *req);
+extern void mconsole_exec(struct mc_request *req);
 extern void mconsole_config(struct mc_request *req);
 extern void mconsole_remove(struct mc_request *req);
 extern void mconsole_sysrq(struct mc_request *req);

--Boundary-00=_KdbvAEkAzpX6H7S--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
