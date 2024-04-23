Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B5AC10F15
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2nOPuUACaHxjsvTBbK286kNs1kGaeWUIM12LDvgezc=; b=wiTUup2g5FcifzHrWvdTPuKwlm
	rm9mfXG3i/omCLHUFIRxn0GwjYXKLMKj7pp1iwFp1Anx7WOTKNtZZQBsbqrORB/6tQhmMbVH0wBlU
	3IpuQrmVSes8h4sSaI/ZmN2DQSvN3ppRDd2h11lAJej3JHWEHSUjcIbBV1e/I+WuW1tcIoei+cpUL
	5MeEW/D2t/IAC//VThQNvYYuGbIaIoLBmmYJDNwfsSs4f2+BnplxrYlyUpIjevwT77lCfnFM5hcr2
	xB54UfhIEB97b6kYNNxN7u2hgoQQM253XWAht9Q+LTyvyPd31rk5HL7B25HoQftdMOxdrIQSRAvzY
	/C1zVjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFk5-0000000HY3L-3LmG;
	Tue, 23 Apr 2024 12:59:25 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFju-0000000HXuw-3P0S
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877149; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=u2nOPuUACaHxjsvTBbK286kNs1kGaeWUIM12LDvgezc=;
	b=X2c/OXqxx/3uwTmpzk3llKGvzGns+RMRmHIppFW7WGRWXrNzzNMlvMIoBC81YzVO26TWTZhzTuMG5YL3Ae9zu7hv5/BaP0oJ9HJtcgJyX017BQbpsn6PlTH4oXDyiE1/w3mKA35TfHd2iKWlUEBEb4LQS65S+uyH5h86Y4wzq18=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSj_1713877148;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSj_1713877148)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:08 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 5/7] um: Add an internal header shared among the user code
Date: Tue, 23 Apr 2024 20:58:56 +0800
Message-Id: <20240423125858.137709-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_055917_744073_BC18D9A1 
X-CRM114-Status: GOOD (  14.19  )
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

Move relevant declarations to this header. This will address
below -Wmissing-prototypes warnings:

arch/um/os-Linux/elf_aux.c:26:13: warning: no previous prototype for ‘scan_elf_aux’ [-Wmissing-prototypes]
arch/um/os-Linux/mem.c:213:13: warning: no previous prototype for ‘check_tmpexec’ [-Wmissing-prototypes]
arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype for ‘wait_stub_done’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/elf_aux.c      |  1 +
 arch/um/os-Linux/internal.h     | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c         |  3 +--
 arch/um/os-Linux/mem.c          |  1 +
 arch/um/os-Linux/skas/mem.c     |  3 +--
 arch/um/os-Linux/skas/process.c |  1 +
 arch/um/os-Linux/start_up.c     |  3 +--
 7 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 344ac403fb5d..0a0f91cf4d6d 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -13,6 +13,7 @@
 #include <init.h>
 #include <elf_user.h>
 #include <mem_user.h>
+#include "internal.h"
 
 typedef Elf32_auxv_t elf_auxv_t;
 
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
new file mode 100644
index 000000000000..317fca190c2b
--- /dev/null
+++ b/arch/um/os-Linux/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_OS_LINUX_INTERNAL_H
+#define __UM_OS_LINUX_INTERNAL_H
+
+/*
+ * elf_aux.c
+ */
+void scan_elf_aux(char **envp);
+
+/*
+ * mem.c
+ */
+void check_tmpexec(void);
+
+/*
+ * skas/process.c
+ */
+void wait_stub_done(int pid);
+
+#endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index e82164f90288..f98ff79cdbf7 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <um_malloc.h>
+#include "internal.h"
 
 #define PGD_BOUND (4 * 1024 * 1024)
 #define STACKSIZE (8 * 1024 * 1024)
@@ -102,8 +103,6 @@ static void setup_env_path(void)
 	}
 }
 
-extern void scan_elf_aux( char **envp);
-
 int __init main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index c6c9495b1432..cf44d386f23c 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -17,6 +17,7 @@
 #include <init.h>
 #include <kern_util.h>
 #include <os.h>
+#include "internal.h"
 
 /*
  * kasan_map_memory - maps memory from @start with a size of @len.
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 953fb10f3f93..1f9c1bffc3a6 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -17,11 +17,10 @@
 #include <skas.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/stub.h>
+#include "../internal.h"
 
 extern char batch_syscall_stub[], __syscall_stub_start[];
 
-extern void wait_stub_done(int pid);
-
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
 					      unsigned long *stack)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1f5c3f2523d1..41a288dcfc34 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -23,6 +23,7 @@
 #include <skas.h>
 #include <sysdep/stub.h>
 #include <linux/threads.h>
+#include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
 {
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 6b21061c431c..89ad9f4f865c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -25,6 +25,7 @@
 #include <ptrace_user.h>
 #include <registers.h>
 #include <skas.h>
+#include "internal.h"
 
 static void ptrace_child(void)
 {
@@ -222,8 +223,6 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern void check_tmpexec(void);
-
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
-- 
2.34.1


