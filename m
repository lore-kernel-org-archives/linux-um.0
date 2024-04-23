Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79C2C10F15
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+7Dfcyc7ewnae17/TPs5HjFgj4pirZ9MfZiM8UFc54=; b=cLHw64cYi7XXWF/o9d45Dv+md+
	JaClfhMsxabuNAVLlCpJyWvGvNVrcwgEJ42GP3yWoU+NPCL8wLeiJEjfQ3jrb6Fb9hyplZ1cbRe7v
	+/Sjkg7JmidtNQEknMIRIej2AY7o7fZDdMRIdIHjLN/quA+34qi4A83OjHLdRiyG2Oc7ma3MH4Lo/
	T4SJcTtkcBzMwBWZ2aui+sHQ9w1mFT4dtNf1wF7dx0fnw8zVWBdgCsVqYbJOMMll8uXj5/yvAFttz
	mN1pswMAwPHg/uzAk4IKm4RYucxloQ0xSoycKNP/HCABAFOYXTPWsJZWY/HhKNsUNszvbHKp7sJcW
	8GLk4RSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEHI-0000000H5Mx-0uUw;
	Tue, 23 Apr 2024 11:25:36 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEH1-0000000H5C0-1uWF
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871515; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=f+7Dfcyc7ewnae17/TPs5HjFgj4pirZ9MfZiM8UFc54=;
	b=mPcHhR215tE4OLPjeyOIrORXNtfIr0nZoSPALgpVABhSdUdxo434LEzxVIrdHXWTai19DN8SKBhkhDlR/IH/NHUoi7swcl+VWc4pI9C6BxYpH6yrDodGdlWFWQVuuyDtisXyFyqsHBNZ3MnXwAPI5449z9lVJu7jc64Le7fK57Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYi3_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYi3_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:13 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/7] um: Add an internal header shared among the user code
Date: Tue, 23 Apr 2024 19:24:55 +0800
Message-Id: <20240423112457.2409319-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_042520_439454_4A17AB7A 
X-CRM114-Status: GOOD (  11.88  )
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
 arch/um/os-Linux/internal.h    | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c        |  2 --
 arch/um/os-Linux/skas/mem.c    |  2 --
 arch/um/os-Linux/start_up.c    |  2 --
 arch/um/scripts/Makefile.rules |  3 ++-
 5 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
new file mode 100644
index 000000000000..2a0ea7853658
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
+extern void scan_elf_aux(char **envp);
+
+/*
+ * mem.c
+ */
+extern void check_tmpexec(void);
+
+/*
+ * skas/process.c
+ */
+extern void wait_stub_done(int pid);
+
+#endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index e82164f90288..9880cfcb9b8a 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -102,8 +102,6 @@ static void setup_env_path(void)
 	}
 }
 
-extern void scan_elf_aux( char **envp);
-
 int __init main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 953fb10f3f93..1b0502fb5c75 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -20,8 +20,6 @@
 
 extern char batch_syscall_stub[], __syscall_stub_start[];
 
-extern void wait_stub_done(int pid);
-
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
 					      unsigned long *stack)
 {
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 6b21061c431c..f920c837428e 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -222,8 +222,6 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern void check_tmpexec(void);
-
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index a8b7d9dab0a6..b8ea5f3bb1fb 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -9,7 +9,8 @@ USER_OBJS += $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h \
+		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLAGS_$(basetarget).o)
 
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
-- 
2.34.1


