Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwC-005VXA-DB
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:26 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 25/27] um: Die if a child dies unexpectedly in seccomp mode
Date: Wed,  3 Mar 2021 16:55:21 +0100
Message-Id: <20210303155523.124277-26-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

When in seccomp mode, we would hang forever on the futex if a child has
died unexpectedly. In contrast, ptrace mode will notice it and kill the
corresponding thread when it fails to run it.

Fix this issue by simply printing a message and aborting. In this case
something from the outside (e.g. OOM killer) has interferred with the
machine and it is reasonable to not try to recover.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/process.c  | 40 +++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c   |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 8514d90cd5fa..283e95731d6f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -192,6 +192,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern int create_mem_file(unsigned long long len);
 
 /* process.c */
+void os_check_child_lost(void);
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
 extern void os_alarm_process(int pid);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e52dd37ddadc..db98fc79d9e2 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -17,6 +17,7 @@
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
+#include <skas/skas.h>
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -102,9 +103,18 @@ void os_stop_process(int pid)
 
 void os_kill_process(int pid, int reap_child)
 {
+	sigset_t chld;
+
+	/* Block SIGCHLD so that we can reap it before the handler runs. */
+	sigemptyset(&chld);
+	sigaddset(&chld, SIGCHLD);
+	sigprocmask(SIG_BLOCK, &chld, NULL);
+
 	kill(pid, SIGKILL);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+
+	sigprocmask(SIG_UNBLOCK, &chld, NULL);
 }
 
 /* Kill off a ptraced child by all means available.  kill it normally first,
@@ -114,11 +124,39 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	sigset_t chld;
+
+	/* Block SIGCHLD so that we can reap it before the handler runs. */
+	sigemptyset(&chld);
+	sigaddset(&chld, SIGCHLD);
+	sigprocmask(SIG_BLOCK, &chld, NULL);
+
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+
+	sigprocmask(SIG_UNBLOCK, &chld, NULL);
+}
+
+void os_check_child_lost(void)
+{
+	int status;
+	pid_t pid;
+
+	/*
+	 * Check if we can reap a child.
+	 * Any expected kills will clean up without this handler being fired.
+	 */
+	pid = waitpid(-1, &status, WNOHANG);
+	if (pid <= 0)
+		return;
+
+	os_warn("Child %d died unexpectedly with status %d, cannot recover in seccomp mode!\r\n",
+		pid, status);
+	/* Kill ourselves including all children. */
+	killpg(os_getpid(), SIGABRT);
 }
 
 /* Don't use the glibc version, which caches the result in TLS. It misses some
@@ -283,5 +321,7 @@ void init_new_thread_signals(void)
 	set_handler(SIGBUS);
 	signal(SIGHUP, SIG_IGN);
 	set_handler(SIGIO);
+	if (using_seccomp)
+		set_handler(SIGCHLD);
 	signal(SIGWINCH, SIG_IGN);
 }
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 96f511d1aabe..d04b39bace53 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -94,6 +94,11 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 	timer_handler(SIGALRM, NULL, &regs);
 }
 
+static void sig_child_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+{
+	os_check_child_lost();
+}
+
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
 	int enabled;
@@ -155,6 +160,8 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
+	/* SIGCHLD is only registered in seccomp mode. */
+	[SIGCHLD] = sig_child_handler,
 	[SIGALRM] = timer_alarm_handler,
 
 	[SIGUSR1] = sigusr1_handler,
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

