Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d88cl-0002fh-OW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:08:35 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d88cj-0005PU-Aw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:08:35 +0000
Received: from [78.47.166.52] (helo=sslproxy04.your-server.de)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d88cc-0000RJ-QX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 19:08:26 +0200
Received: from [192.168.0.32] (helo=webmail03.your-server.de)
	by sslproxy04.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.84_2)
	(envelope-from <thomas@m3y3r.de>) id 1d88cc-0000O9-KN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 19:08:26 +0200
Date: Tue, 09 May 2017 19:08:26 +0200
Message-ID: <20170509190826.Horde.ZyKnsvHENwemIv63o-uIFDu@webmail.your-server.de>
From: Thomas Meyer <thomas@m3y3r.de>
Content-Type: multipart/mixed; boundary="=_7tRvAI-PcIh_SjNb1QXzC7S"
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] um: Document change_sig and switch to bool type
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format.

--=_7tRvAI-PcIh_SjNb1QXzC7S
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline




--=_7tRvAI-PcIh_SjNb1QXzC7S
Content-Type: text/x-diff;
	name=0001-um-Document-change_sig-and-switch-to-bool-type.patch
Content-Disposition: attachment; size=3013;
	filename=0001-um-Document-change_sig-and-switch-to-bool-type.patch

>>From 90c1f4bb11d0ce6fa36051f0d8a94f11580b4b37 Mon Sep 17 00:00:00 2001
From: Thomas Meyer <thomas@m3y3r.de>
Date: Tue, 9 May 2017 18:56:28 +0200
Subject: [PATCH] um: Document change_sig and switch to bool type

---
 arch/um/include/shared/os.h |  3 ++-
 arch/um/os-Linux/main.c     |  4 ++--
 arch/um/os-Linux/signal.c   | 10 +++++++++-
 arch/um/os-Linux/start_up.c |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index de5d572..8d0ae77 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -9,6 +9,7 @@
 #define __OS_H__
 
 #include <stdarg.h>
+#include <stdbool.h>
 #include <irq_user.h>
 #include <longjmp.h>
 #include <mm_id.h>
@@ -226,7 +227,7 @@ extern void timer_set_signal_handler(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void remove_sigstack(void);
 extern void set_handler(int sig);
-extern int change_sig(int signal, int on);
+extern int change_sig(int signal, bool on);
 extern void block_signals(void);
 extern void unblock_signals(void);
 extern int get_signals(void);
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 9d499de..f23b3c1 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -152,7 +152,7 @@ int __init main(int argc, char **argv, char **envp)
 #endif
 
 	do_uml_initcalls();
-	change_sig(SIGPIPE, 0);
+	change_sig(SIGPIPE, false);
 	ret = linux_main(argc, argv);
 
 	/*
@@ -160,7 +160,7 @@ int __init main(int argc, char **argv, char **envp)
 	 * off the profiling time, but UML dies with a SIGPROF just before
 	 * exiting when profiling is active.
 	 */
-	change_sig(SIGPROF, 0);
+	change_sig(SIGPROF, false);
 
 	/*
 	 * This signal stuff used to be in the reboot case.  However,
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index a86d7cc..024f666 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -8,6 +8,7 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <signal.h>
 #include <strings.h>
@@ -231,7 +232,14 @@ void set_handler(int sig)
 		panic("sigprocmask failed - errno = %d\n", errno);
 }
 
-int change_sig(int signal, int on)
+/**
+ * change_sig() - enable or disable a signal of the calling thread
+ * @signal:	The number to signal to en- or disable
+ * @on:		What to do: enable or disable the given signal
+ *
+ * Return: Zero if successful, negative error number if unsuccessful.
+ */
+int change_sig(int signal, bool on)
 {
 	sigset_t sigset;
 
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358e..8279371a 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -32,7 +32,7 @@ static void ptrace_child(void)
 	int pid = os_getpid(), ppid = getppid();
 	int sc_result;
 
-	if (change_sig(SIGWINCH, 0) < 0 ||
+	if (change_sig(SIGWINCH, false) < 0 ||
 	    ptrace(PTRACE_TRACEME, 0, 0, 0) < 0) {
 		perror("ptrace");
 		kill(pid, SIGKILL);
-- 
2.9.3


--=_7tRvAI-PcIh_SjNb1QXzC7S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--=_7tRvAI-PcIh_SjNb1QXzC7S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=_7tRvAI-PcIh_SjNb1QXzC7S--



