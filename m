Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5C4C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g8SmPXZh0kSlENkQTk+yy/Du9QzuSyPCCqTDmFT5AAA=; b=z1+nYIVX/WuqJu
	pWaUEzV10dM1k58nknx9k4Aq/IJ4adezgJV1p0WQDol4CplFGGg9pO2/dBxqz/KhRH+Sk3O1ne6Y1
	sSJr+4N8AgcnKcq+0JR5TTU/7g9rnTIe3/KvpjfrF///GZhugjae8TnbN6IAOquG6HvdggRd5BK7I
	WxeAsGUFDopcqZwyc8b/isLWjvdE8fnKtz7vJSCeZO9JOBI5P3Qnj9eglmlScVda5iWB6JNC0tuxJ
	6csjJ6TXBsVI/YVn2mg9pG4ZfoqJ+Kg96Xe6NpITNJcxjwa8rGP81CoFDTHQ4a2ikng/Yzt3yTFhS
	ElpQPm+oyOlbIlWndDTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFM-007fyH-6j; Tue, 22 Nov 2022 10:11:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-007feo-Op
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=utAvEKQ+jPHNcrosqX7HWwVjeA1rAK1oeYCrGOYxwl4=;
	t=1669111857; x=1670321457; b=h2kxzZt5szfw92eEjl4MxVWSLZmn6dVIkWNrqI5AWlUKid3
	RKkjr1ZrxigJIvifkX9Bi+0Ip63FEdOeu3aj75q8PSKvBFAwjTUlps6Ic9RS/gD4TBaQ3/0DzaBcg
	3EJ7FuLb8qlh88ftpR9Mm9XbFkI/E+V/09whvn3LvcKfy4EJgkOBX5GFPvdYqR47Sr06a+ZG4dw8T
	3jDqbMD69/Pa/owAowgb3+/53rLvrR3vLmHycqw9FJqvxz40VMxiIvpjkhsiRcGaf6dkwIYId2dY8
	TM2NjiGAH8rl08hjxiv5g2QkfktwFxqPCwGCbyFlzVc39IbgvPp3I1yvm6uJNf8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEu-006IGn-2y;
	Tue, 22 Nov 2022 11:10:53 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 26/28] um: Die if a child dies unexpectedly in seccomp mode
Date: Tue, 22 Nov 2022 11:07:57 +0100
Message-Id: <20221122100759.208290-27-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021059_884260_0DAEE2F6 
X-CRM114-Status: GOOD (  16.28  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

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
index d1f1dedad83b..07683f45d7e1 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -192,6 +192,7 @@ extern void get_host_cpu_features(
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
index 24a403a70a02..d8c92e04c873 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -108,6 +108,11 @@ static void timer_real_alarm_handler(mcontext_t *mc)
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
@@ -169,6 +174,8 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
+	/* SIGCHLD is only registered in seccomp mode. */
+	[SIGCHLD] = sig_child_handler,
 	[SIGALRM] = timer_alarm_handler,
 
 	[SIGUSR1] = sigusr1_handler,
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
