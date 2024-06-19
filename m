Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AB7C27C53
	for <linux-um@archiver.kernel.org>; Wed, 19 Jun 2024 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OefifXSN/EV7YftSO4xnY4e21SDEgBce03i6HkE0zS4=; b=ZSWY7byzqrL4WA6/uJFoKIKVrx
	va+WZ5VwFXend9B9PkJPuH2/UJ/3O/kNC5QPWPQZ62eHzaBUf51Hmw6IesvY9Jc2Pwe+6XghU7DOe
	4hSsiOwb18N7/yNYklQuAAc4z9lmYhenIHTLQI2BXZNyho+9n9re26jN4H1Ayj+GBcpl2jYtXfD5u
	PT7FinYgQ0WevWtTF5TDq3Wmn3+DcwxvhYNRk596UXYWvMRNh+BZNrIQrQBS71hgQLbKJuGV8io/X
	7iuR3Ayt3gc6n29WhCxFxmE7cOrC5QXSn/JC8tCLrlEZdkbXtwtP+iCoqAUQ+p8cCSz8worGmsrnj
	edufKm1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLu-00000001pVD-44NO;
	Wed, 19 Jun 2024 15:36:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLr-00000001pQE-2GNw
	for linux-um@lists.infradead.org;
	Wed, 19 Jun 2024 15:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OefifXSN/EV7YftSO4xnY4e21SDEgBce03i6HkE0zS4=;
	t=1718811359; x=1720020959; b=LE1fy+EGHe3kQecgoWmLFHHXjXrSVg7MaYo7KSHunsWcPT8
	SaQz8/4Wez9yb8j718GGtFJklfqnbStD698atTqb3LtZbY+vgBrqRbCib6mYNBrl5V519ZVoA2hyU
	66vtHz9w/o9qLpMqS0d3utTBuybqdUheo+SUoTleHz3timwhT7NZBncrZ+LYyPa+7NGoDcqQ2xjxH
	F/GzigcBUhfP//KnTD85mW2vYJiOG81UXgCJu6DfwInJ0A4NenTG8SsaYkzkSQtGTeM4ubNk15fVk
	myxK5sxICYEAoW3ewC7J2qUi6xKk3VrsmWMV0d/o1OsZXln8JMqF4SKPnjWwgFYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sJxLo-000000072rR-18pn;
	Wed, 19 Jun 2024 17:35:56 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v5 6/7] um: Discover host_task_size from envp
Date: Wed, 19 Jun 2024 17:34:10 +0200
Message-ID: <20240619153411.2596774-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619153411.2596774-1-benjamin@sipsolutions.net>
References: <20240619153411.2596774-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_083559_666314_CFE1A39B 
X-CRM114-Status: GOOD (  19.59  )
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
2.45.1


