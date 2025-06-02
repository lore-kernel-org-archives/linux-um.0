Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FE9C61CE8
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQ6zwnbSepHLMFBbDn9cQ1PE4Yss4Y/Yn9ow81dEnzE=; b=wSnVfWXMrCnZbN7aomOtHa7T/W
	9P/UNCeJFUpUMCW88Todw/wSXd7BDBcO/Kv1kcDnKgpsQULIaOMUcNCUfaVL4hIvWQmt8oZH3vhDk
	YhNN+0tUjszOoseN5a3jqcB1uC2b88DNmrx/oBwth+NseJwhpPXFbvP2zKR1km36iLGs7KA12DczW
	lqq6x+p7R619yOakC5eUPuTo1hHUVRnPRT0EXGYN8I2v/u0GrBt22PGTPJTDPTRtn1zdoyPHBGLhD
	SQLAhJzgK3TBXnedYnm65ao6rE5bgBHI3wi0k/tnmEkP2PPT75GJy3SOteco+2ArefH3XZzGgjw1r
	THNBAjgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4oM-00000007PoK-2SuH;
	Mon, 02 Jun 2025 13:02:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4nS-00000007PfZ-22j9
	for linux-um@lists.infradead.org;
	Mon, 02 Jun 2025 13:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XQ6zwnbSepHLMFBbDn9cQ1PE4Yss4Y/Yn9ow81dEnzE=;
	t=1748869306; x=1750078906; b=P01JOetcKvY5OSdN5u8CB8g4OIJE3xXvnq8/LVC3PbyD9Ft
	iGJzFDzNMPl8N/8HjiC6lixksw/I52c1pqscaB1LHEqiahb9eFOxOp3V+UEL8vqI/X+leQfA98j6K
	bxKQefW6SWReDkYxyu3OW0KpjwtH1b7teIpnHv1Xmh0Il+/yTanV9ZSW3SAFXLZXkTj7GLbWgvu9p
	ySp/8zxR/1QWUMt2yPBa9j5j4CSbkHXPyxUHLxwek30c2aVfR63XL27ivnzQfsbF69bfu2i1hKf8t
	YNMTfENhYxXFfWH4qlghPjlFosotDCwCQRAk7c1/EpC5bZ8BFdjroGSpi62KYX0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uM4nO-00000005j9h-3JN1;
	Mon, 02 Jun 2025 15:01:43 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 6/7] um: Add SECCOMP support detection and initialization
Date: Mon,  2 Jun 2025 15:00:51 +0200
Message-ID: <20250602130052.545733-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602130052.545733-1-benjamin@sipsolutions.net>
References: <20250602130052.545733-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_060146_678185_93722F77 
X-CRM114-Status: GOOD (  26.07  )
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
initilizes the exec registers. The support is only enabled if the
seccomp= kernel parameter is set to either "on" or "auto". With "auto" a
fallback to ptrace mode will happen if initialization failed.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v3:
- Fix FP size detection on some hosts. The MAP_SHARED | MAP_ANON mapping
  would not always be shared after fork(), resulting in the detection to
  fail.
- Add runtime option to select seccomp mode
---
 arch/um/os-Linux/registers.c |   4 +-
 arch/um/os-Linux/start_up.c  | 177 ++++++++++++++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 4 deletions(-)

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
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 93fc82c01aba..5d2e604ab02d 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
@@ -24,6 +25,13 @@
 #include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
+#include <stdbool.h>
+#include <stub-data.h>
+#include <sys/prctl.h>
+#include <linux/seccomp.h>
+#include <linux/filter.h>
+#include <sysdep/mcontext.h>
+#include <sysdep/stub.h>
 #include <registers.h>
 #include <skas.h>
 #include "internal.h"
@@ -224,6 +232,136 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
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
+	_exit(0);
+}
+
+static int __init seccomp_helper(void *data)
+{
+	static struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+			 offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_clock_nanosleep, 1, 0),
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
+	};
+	static struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	struct sigaction sa;
+
+	seccomp_test_stub_data->mctx_offset = 1;
+
+	set_sigstack(seccomp_test_stub_data->sigstack,
+			sizeof(seccomp_test_stub_data->sigstack));
+
+	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+	sa.sa_sigaction = (void *) sigsys_handler;
+	sa.sa_restorer = NULL;
+	if (sigaction(SIGSYS, &sa, NULL) < 0)
+		exit(1);
+
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+			SECCOMP_FILTER_FLAG_TSYNC, &prog) != 0)
+		exit(2);
+
+	sleep(0);
+
+	/* Never reached. */
+	_exit(3);
+}
+
+static bool __init init_seccomp(void)
+{
+	int pid;
+	int status;
+	int n;
+	unsigned long sp;
+
+	/*
+	 * We check that we can install a seccomp filter and then exit(0)
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
+	/* Use the syscall data area as stack, we just need something */
+	sp = (unsigned long)&seccomp_test_stub_data->syscall_data +
+	     sizeof(seccomp_test_stub_data->syscall_data) -
+	     sizeof(void *);
+	pid = clone(seccomp_helper, (void *)sp, CLONE_VFORK | CLONE_VM, NULL);
+
+	if (pid < 0)
+		fatal_perror("check_seccomp : clone failed");
+
+	CATCH_EINTR(n = waitpid(pid, &status, __WCLONE));
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
+
+
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
@@ -278,6 +416,30 @@ void  __init get_host_cpu_features(
 	}
 }
 
+static int seccomp_config __initdata;
+
+static int __init uml_seccomp_config(char *line, int *add)
+{
+	*add = 0;
+
+	if (strcmp(line, "off") == 0)
+		seccomp_config = 0;
+	else if (strcmp(line, "auto") == 0)
+		seccomp_config = 1;
+	else if (strcmp(line, "on") == 0)
+		seccomp_config = 2;
+	else
+		fatal("Invalid seccomp option '%s', expected on/auto/off\n",
+		      line);
+
+	return 0;
+}
+
+__uml_setup("seccomp=", uml_seccomp_config,
+"seccomp=<on/auto/off>\n"
+"    Whether to run userspace using SECCOMP.\n"
+"    This is insecure and should only be used with a trusted userspace\n\n"
+);
 
 void __init os_early_checks(void)
 {
@@ -286,13 +448,24 @@ void __init os_early_checks(void)
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
-	check_ptrace();
-
 	/* Need to check this early because mmapping happens before the
 	 * kernel is running.
 	 */
 	check_tmpexec();
 
+	if (seccomp_config) {
+		if (init_seccomp()) {
+			using_seccomp = 1;
+			return;
+		}
+
+		if (seccomp_config == 2)
+			fatal("SECCOMP userspace requested but not functional!");
+	}
+
+	using_seccomp = 0;
+	check_ptrace();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
-- 
2.49.0


