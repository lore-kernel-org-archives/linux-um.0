Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82173C30658
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqppFOwCWxq3W3IFvIhZUTrM1tp6ZgBBUUCXkfbW3JQ=; b=bs+QtaR6JQ/xSx3BIr/ZxQ35Zl
	g6GCOfy4IWidXRIz3d9y+PWPZnFxZIiAr7nEGkuiF/gvx01R95s/dTGGgSwcH/7FVlC9jN5BIr41J
	37kmcOfrPUQ0QLbDGTpBXVi0Gc+18M6n+9YeuzTSQcI73GPI7BFYUHvtICLPoIRlacqvporTRJEH/
	o/ouPaiWZ64+aKDAGnoa4IBqS1DRTzAR/EXfJZTZcw0kX8aeqEZhPc878q1ZcK2ZJ5nuCfrWIHsOz
	Qzx8xyzXwGKw4noEn9sW8nyzFT4ZuAJi3RJtHZ7eKdaklzlruGD6ZFsJ6PFtFUw73rhhrqcI5uMJ9
	e1QWVZbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT8C-000000074j0-3u8w;
	Wed, 26 Jun 2024 13:56:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT85-000000074eF-1Ndr
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oqppFOwCWxq3W3IFvIhZUTrM1tp6ZgBBUUCXkfbW3JQ=;
	t=1719410169; x=1720619769; b=jYmc6XjmdozJkaCiJaH6p/fXf+LeWT3DzJjHJ0xZ9kQQItO
	mlBEzzXBbE4BisK2/bnKpCybzirndYiYdwBqt+17toYfvqdRzOHODFSAR7KrDVWk8/0ziatxXrzJA
	2fKd+lsJjJNnuuu3nJiNqj9wYuhEb6VnwyZy6jteYeLLXHU/6/UXpYLB3Z97MhEaPAQ8UUGmdmt3o
	OSoQwjgToXuGy4bDUSKm1aQ+FhPMQYHTD1QgRkZG226CpvWH9rJJVVZlYfFgKoDhIxYBvLNgFh/Rp
	lyVP6/zM8F09OYuOhxu6rHnbjnN8wgZ/3yaW/9IBfwM4Ku1YcOXBYUN+jRBCzAEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT83-00000003rXd-2GUF;
	Wed, 26 Jun 2024 15:56:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 6/7] um: Discover host_task_size from envp
Date: Wed, 26 Jun 2024 15:53:49 +0200
Message-ID: <20240626135350.493110-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626135350.493110-1-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065609_590765_9C3B7269 
X-CRM114-Status: GOOD (  19.40  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

When loading the UML binary, the host kernel will place the stack at the
highest possible address. It will then map the program name and
environment variables onto the start of the stack.

As such, an easy way to figure out the host_task_size is to use the
highest pointer to an environment variable as a reference.

Ensure that this works by disabling address layout randomization and
re-executing UML in case it was enabled.

This increases the available TASK_SIZE for 64 bit UML considerably.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/as-layout.h |  2 +-
 arch/um/include/shared/os.h        |  2 +-
 arch/um/kernel/um_arch.c           |  4 ++--
 arch/um/os-Linux/main.c            |  9 ++++++++-
 arch/x86/um/os-Linux/task_size.c   | 19 +++++++++++++++----
 5 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index c22f46a757dc..480bb44ea1f2 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -48,7 +48,7 @@ extern unsigned long brk_start;
 extern unsigned long host_task_size;
 extern unsigned long stub_start;
 
-extern int linux_main(int argc, char **argv);
+extern int linux_main(int argc, char **argv, char **envp);
 extern void uml_finishsetup(void);
 
 struct siginfo;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index aff8906304ea..db644fc67069 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -327,7 +327,7 @@ extern int __ignore_sigio_fd(int fd);
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
-extern unsigned long os_get_top_address(void);
+extern unsigned long os_get_top_address(char **envp);
 
 long syscall(long number, ...);
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 5ab1a92b6bf7..046eaf356b28 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -305,7 +305,7 @@ static void parse_cache_line(char *line)
 	}
 }
 
-int __init linux_main(int argc, char **argv)
+int __init linux_main(int argc, char **argv, char **envp)
 {
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
@@ -327,7 +327,7 @@ int __init linux_main(int argc, char **argv)
 	if (have_console == 0)
 		add_arg(DEFAULT_COMMAND_LINE_CONSOLE);
 
-	host_task_size = os_get_top_address();
+	host_task_size = os_get_top_address(envp);
 	/* reserve a few pages for the stubs (taking care of data alignment) */
 	/* align the data portion */
 	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..9a61b1767795 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -11,6 +11,7 @@
 #include <signal.h>
 #include <string.h>
 #include <sys/resource.h>
+#include <sys/personality.h>
 #include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
@@ -108,6 +109,12 @@ int __init main(int argc, char **argv, char **envp)
 	char **new_argv;
 	int ret, i, err;
 
+	/* Disable randomization and re-exec if it was changed successfully */
+	ret = personality(PER_LINUX | ADDR_NO_RANDOMIZE);
+	if (ret >= 0 && (ret & (PER_LINUX | ADDR_NO_RANDOMIZE)) !=
+			 (PER_LINUX | ADDR_NO_RANDOMIZE))
+		execve("/proc/self/exe", argv, envp);
+
 	set_stklim();
 
 	setup_env_path();
@@ -140,7 +147,7 @@ int __init main(int argc, char **argv, char **envp)
 #endif
 
 	change_sig(SIGPIPE, 0);
-	ret = linux_main(argc, argv);
+	ret = linux_main(argc, argv, envp);
 
 	/*
 	 * Disable SIGPROF - I have no idea why libc doesn't do this or turn
diff --git a/arch/x86/um/os-Linux/task_size.c b/arch/x86/um/os-Linux/task_size.c
index 1dc9adc20b1c..33c26291545a 100644
--- a/arch/x86/um/os-Linux/task_size.c
+++ b/arch/x86/um/os-Linux/task_size.c
@@ -65,7 +65,7 @@ static int page_ok(unsigned long page)
 	return ok;
 }
 
-unsigned long os_get_top_address(void)
+unsigned long os_get_top_address(char **envp)
 {
 	struct sigaction sa, old;
 	unsigned long bottom = 0;
@@ -142,10 +142,21 @@ unsigned long os_get_top_address(void)
 
 #else
 
-unsigned long os_get_top_address(void)
+unsigned long os_get_top_address(char **envp)
 {
-	/* The old value of CONFIG_TOP_ADDR */
-	return 0x7fc0002000;
+	unsigned long top_addr = (unsigned long) &top_addr;
+	int i;
+
+	/* The earliest variable should be after the program name in ELF */
+	for (i = 0; envp[i]; i++) {
+		if ((unsigned long) envp[i] > top_addr)
+			top_addr = (unsigned long) envp[i];
+	}
+
+	top_addr &= ~(UM_KERN_PAGE_SIZE - 1);
+	top_addr += UM_KERN_PAGE_SIZE;
+
+	return top_addr;
 }
 
 #endif
-- 
2.45.2


