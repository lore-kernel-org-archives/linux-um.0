Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2672C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2rhSc5wDBU79DEn8E04pU/Bss+i/ENtiGb4Dv4IETAI=; b=xp06sENdh8a277
	oSD9gus3rvibTr2ej1giHzdjLtcYVVp5Xv9/hHmGmI+8H/ZbZxwJ33m1ccP1JUh0/wEQrJxdHAnDK
	jSbRkj054W4EiMJNSw+AW/xpfHwZxENX3xFCxRdZGoUy78+8fipmPikdNn0fZxX4qRh7r3zQmcYet
	uPNZK1TeJzAkzsOxgoXM+PIW+Inawdf1AREtkf2599bEwmi/s5tV67F74tkNj2C/hBt2UwSB8PPOz
	LDudt2eeuu7i/GuYf9kUIm1L+797Gjx1wC64/9jNsFqsr/skKadyE+KkRf+pE1zFF2Hd+Gri3IMM+
	s8tymWOoSgzrGcvSBB9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFT-007g7p-TN; Tue, 22 Nov 2022 10:11:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF2-007fee-U0
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=84kn9+/iVI02EtcyRQnFNVnoxVe0yKlrS5ZZyVCDKDQ=;
	t=1669111860; x=1670321460; b=dLRPXAdFL9YUooU1+nOWuzYr6vQkXjqCztYH5Jd5u7e0CB9
	crx3DcFn4wjb0ZYwIJCVO/Bv3wKJ6leTNhKyzKj3ez/WwGks7z6Udgcw//r48d3u2PJxqJDJCJoJi
	oQ9rJFrKqaCm7dd8LE1Atv1n+attKUKOUdhdda0AJupmVEEDmu7kxn2ADSp6kSZE78iw3O3rXe2mg
	507oM1eYPQrtcG6swwJfwraLqjT/qIe5vNhEqrgQOX55jdVqerpjyViASC712sz4FrfCAJinTF1oT
	A182KBetB6yy2pxHWnipPU/2Uu86ebzsDo4rCbY4sbUkRdOfU5cl4oPM0zuijVDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEu-006IGn-1L;
	Tue, 22 Nov 2022 11:10:52 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 25/28] um: Add SECCOMP support detection and initialization
Date: Tue, 22 Nov 2022 11:07:56 +0100
Message-Id: <20221122100759.208290-26-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_098213_0ACD1BF7 
X-CRM114-Status: GOOD (  22.28  )
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

This detects seccomp support, sets the global using_seccomp variable and
initilizes the exec registers. For now, the implementation simply falls
through to the ptrace startup code, meaning that it is unused.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/skas.h |   6 ++
 arch/um/os-Linux/registers.c       |   4 +-
 arch/um/os-Linux/skas/process.c    |   3 +
 arch/um/os-Linux/start_up.c        | 136 ++++++++++++++++++++++++++++-
 4 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index c93d2cbc8f32..f10599995d4d 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -6,8 +6,14 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
+#include <linux/kconfig.h>
 #include <sysdep/ptrace.h>
 
+#ifdef CONFIG_UML_SECCOMP
+extern int using_seccomp;
+#else
+#define using_seccomp 0
+#endif
 extern int userspace_pid[];
 
 extern int user_thread(unsigned long stack, int flags);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index bd80b921add0..528381496aa7 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -13,8 +13,8 @@
 
 /* This is set once at boot time and not changed thereafter */
 
-static unsigned long exec_regs[MAX_REG_NR];
-static unsigned long exec_fp_regs[FP_SIZE];
+unsigned long exec_regs[MAX_REG_NR];
+unsigned long exec_fp_regs[FP_SIZE];
 
 int init_pid_registers(int pid)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index cdbab5a864e4..44a7d49538ce 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -247,6 +247,9 @@ static int userspace_tramp(void *stack)
 	return 0;
 }
 
+#ifdef CONFIG_UML_SECCOMP
+int using_seccomp;
+#endif
 int userspace_pid[NR_CPUS];
 int kill_userspace_mm[NR_CPUS];
 
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 8b0e98ab842c..f84eb13a0b98 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/kconfig.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -22,8 +24,17 @@
 #include <os.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
+#ifdef CONFIG_UML_SECCOMP
+#include <stdbool.h>
+#include <stub-data.h>
+#include <sys/prctl.h>
+#include <linux/seccomp.h>
+#include <linux/filter.h>
+#include <sysdep/mcontext.h>
+#endif
 #include <registers.h>
 #include <skas.h>
+#include <sysdep/stub.h>
 
 static void ptrace_child(void)
 {
@@ -221,6 +232,114 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
+#ifdef CONFIG_UML_SECCOMP
+extern unsigned long exec_regs[MAX_REG_NR];
+extern unsigned long exec_fp_regs[FP_SIZE];
+
+static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+{
+	struct stub_data *data = get_stub_page();
+	ucontext_t *uc = p;
+
+	/* Stow away the location of the mcontext in the stack */
+	data->mctx_offset = (unsigned long)&uc->uc_mcontext -
+			    (unsigned long)&data->sigstack[0];
+	exit(0);
+}
+
+static bool __init init_seccomp(void)
+{
+	struct stub_data *data;
+	int pid;
+	int status;
+	int n;
+
+	/* We check that we can install a seccomp filter and then exit(0)
+	 * from a trapped syscall.
+	 *
+	 * Note that we cannot verify that no seccomp filter already exists
+	 * for a syscall that results in the process/thread to be killed.
+	 */
+
+	os_info("Checking that seccomp filters can be installed...");
+
+	data = mmap(0, sizeof(*data),
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON, 0, 0);
+
+	pid = fork();
+	if (pid == 0) {
+		static struct sock_filter filter[] = {
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				offsetof(struct seccomp_data, nr)),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_clock_nanosleep, 1, 0),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
+		};
+		static struct sock_fprog prog = {
+			.len = ARRAY_SIZE(filter),
+			.filter = filter,
+		};
+		struct sigaction sa;
+
+		set_sigstack(data->sigstack, sizeof(data->sigstack));
+
+		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+		sa.sa_sigaction = (void *) sigsys_handler;
+		sa.sa_restorer = NULL;
+		if (sigaction(SIGSYS, &sa, NULL) < 0)
+			exit(1);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+			    SECCOMP_FILTER_FLAG_TSYNC, &prog) != 0)
+			exit(2);
+
+		sleep(0);
+
+		/* Never reached. */
+		exit(3);
+	}
+
+	if (pid < 0)
+		fatal_perror("check_seccomp : fork failed");
+
+	CATCH_EINTR(n = waitpid(pid, &status, 0));
+	if (n < 0)
+		fatal_perror("check_seccomp : waitpid failed");
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		int r;
+		struct uml_pt_regs *regs = calloc(sizeof(struct uml_pt_regs), 1);
+
+		/* Copy registers, the init_registers function assumes ptrace. */
+		r = get_stub_state(regs, data);
+
+		memcpy(exec_regs, regs->gp, sizeof(exec_regs));
+		memcpy(exec_fp_regs, regs->fp, sizeof(exec_fp_regs));
+
+		munmap(data, sizeof(*data));
+
+		free(regs);
+
+		if (r) {
+			os_info("failed to fetch registers\n");
+			return false;
+		}
+
+		os_info("OK\n");
+		return true;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
+		os_info("missing\n");
+	else
+		os_info("error\n");
+
+	munmap(data, sizeof(*data));
+	return false;
+}
+#endif
+
 extern void check_tmpexec(void);
 
 static void __init check_coredump_limit(void)
@@ -285,13 +404,26 @@ void __init os_early_checks(void)
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
-	check_ptrace();
-
 	/* Need to check this early because mmapping happens before the
 	 * kernel is running.
 	 */
 	check_tmpexec();
 
+#ifdef CONFIG_UML_SECCOMP
+	using_seccomp = 0;
+
+	if (init_seccomp()) {
+		/* Not fully implemented */
+#if 0
+		using_seccomp = 1;
+
+		return;
+#endif
+	}
+#endif
+
+	check_ptrace();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
