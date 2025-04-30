Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D14C3ABB2
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2CQCFQNBNrZgoLl/BaoTH5r+ajzIU6it50TIKwtMO8=; b=WctNjV1ULevqwVcT7ZjSUFZ+gz
	FXSErLYkZudnv8G/fWtXg04Wlb8qYQ6s2ybJ0/Y3TKRAkOx+8ai/q+3uRCsE7B8g9OItKo6qJ2UN8
	VgWRDEz5MjeGaB+SYMRslcoIW9RRdZbvqC9eVjwepCQyByA+QMlIHZFrG5nUOzmnGWOxCI9k+tiHo
	YLR5xqUmQ2aeEvdpsJxdijJaeoMzoSJ2rzVRDSSzrxA58tNpGoHrQagkvcrDjBYKBOm2dA7QwOY1w
	TFEwxySiqD8fIh+kdVFnXaueTCvU3ibMdZni9hUwp+RY8fvBLK6cXUZTDr9T07+nv/JmqzsXTlBIj
	zHIJb9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zV-0000000DO1q-251B;
	Wed, 30 Apr 2025 16:08:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wu-0000000DNgH-2oFu
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=N2CQCFQNBNrZgoLl/BaoTH5r+ajzIU6it50TIKwtMO8=;
	t=1746029176; x=1747238776; b=U/gVaDES2qg1LkqiNVPKXU/TP9yo6SEtGcltNl0zyjlbi2b
	pCmUy94ezoaxqcJFoh9ITcxKGcZw/WpU7UWaGpx2coQ70NljTk+P7iugUni3s0bjPFzPGhoqocdys
	4TMk/MQKmQNgoiDDjC0kO/1XUSqIK/X7KqvFQsvzTX6sixWEg3kYGBydOph/oCaWGjA/4fNcVRHh8
	Y3iHfTU5JDjk+NA61lhxmQPVR6CQXHiwjgiQaOtUh1CoFJVv7G+Dn8Bq0lgYx0zDGEdCK/lWBRiLQ
	gsRlHOZRP/671AtJPR6ACXtwJvloCWmDGh6r1lXME9L+Mr0LATLTI3AiW0UGlt8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wq-0000000DxyX-11Jm;
	Wed, 30 Apr 2025 18:06:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 4/8] um: Add SECCOMP support detection and initialization
Date: Wed, 30 Apr 2025 18:04:09 +0200
Message-ID: <20250430160413.3250227-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090616_854213_DFA83842 
X-CRM114-Status: GOOD (  21.40  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This detects seccomp support, sets the global using_seccomp variable and
initilizes the exec registers.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/skas/skas.h |   5 +
 arch/um/os-Linux/registers.c       |   4 +-
 arch/um/os-Linux/skas/process.c    |   3 +
 arch/um/os-Linux/start_up.c        | 146 ++++++++++++++++++++++++++++-
 4 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index 85c50122ab98..ff54aced05cc 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -8,6 +8,11 @@
 
 #include <sysdep/ptrace.h>
 
+#ifdef CONFIG_UML_SECCOMP
+extern int using_seccomp;
+#else
+#define using_seccomp 0
+#endif
 extern int userspace_pid[];
 
 extern void new_thread_handler(void);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index d7ca148807b2..bfba2cbc9478 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -14,8 +14,8 @@
 
 /* This is set once at boot time and not changed thereafter */
 
-static unsigned long exec_regs[MAX_REG_NR];
-static unsigned long *exec_fp_regs;
+unsigned long exec_regs[MAX_REG_NR];
+unsigned long *exec_fp_regs;
 
 int init_pid_registers(int pid)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 97c2f964f5fc..5e4a38aea68d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -309,6 +309,9 @@ static int __init init_stub_exe_fd(void)
 }
 __initcall(init_stub_exe_fd);
 
+#ifdef CONFIG_UML_SECCOMP
+int using_seccomp;
+#endif
 int userspace_pid[NR_CPUS];
 
 /**
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 93fc82c01aba..ab202ad430f6 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
@@ -24,6 +25,15 @@
 #include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
+#ifdef CONFIG_UML_SECCOMP
+#include <stdbool.h>
+#include <stub-data.h>
+#include <sys/prctl.h>
+#include <linux/seccomp.h>
+#include <linux/filter.h>
+#include <sysdep/mcontext.h>
+#include <sysdep/stub.h>
+#endif
 #include <registers.h>
 #include <skas.h>
 #include "internal.h"
@@ -224,6 +234,128 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
+#ifdef CONFIG_UML_SECCOMP
+extern unsigned long host_fp_size;
+extern unsigned long exec_regs[MAX_REG_NR];
+extern unsigned long *exec_fp_regs;
+
+__initdata static struct stub_data *seccomp_test_stub_data;
+
+static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+{
+	ucontext_t *uc = p;
+
+	/* Stow away the location of the mcontext in the stack */
+	seccomp_test_stub_data->mctx_offset = (unsigned long)&uc->uc_mcontext -
+					      (unsigned long)&seccomp_test_stub_data->sigstack[0];
+	exit(0);
+}
+
+static bool __init init_seccomp(void)
+{
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
+	seccomp_test_stub_data = mmap(0, sizeof(*seccomp_test_stub_data),
+				      PROT_READ | PROT_WRITE,
+				      MAP_SHARED | MAP_ANON, 0, 0);
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
+		set_sigstack(seccomp_test_stub_data->sigstack,
+			     sizeof(seccomp_test_stub_data->sigstack));
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
+		struct uml_pt_regs *regs;
+		unsigned long fp_size;
+		int r;
+
+		/* Fill in the host_fp_size from the mcontext. */
+		regs = calloc(1, sizeof(struct uml_pt_regs));
+		get_stub_state(regs, seccomp_test_stub_data, &fp_size);
+		host_fp_size = fp_size;
+		free(regs);
+
+		/* Repeat with the correct size */
+		regs = calloc(1, sizeof(struct uml_pt_regs) + host_fp_size);
+		r = get_stub_state(regs, seccomp_test_stub_data, NULL);
+
+		/* Store as the default startup registers */
+		exec_fp_regs = malloc(host_fp_size);
+		memcpy(exec_regs, regs->gp, sizeof(exec_regs));
+		memcpy(exec_fp_regs, regs->fp, host_fp_size);
+
+		munmap(seccomp_test_stub_data, sizeof(*seccomp_test_stub_data));
+
+		free(regs);
+
+		if (r) {
+			os_info("failed to fetch registers: %d\n", r);
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
+	munmap(seccomp_test_stub_data, sizeof(*seccomp_test_stub_data));
+	return false;
+}
+#endif
+
+
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
@@ -286,13 +418,23 @@ void __init os_early_checks(void)
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
+		using_seccomp = 1;
+
+		return;
+	}
+#endif
+
+	check_ptrace();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
-- 
2.49.0


