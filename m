Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B452BC54E63
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHCH1Ratt4UqxQ1lP5soIX13BBdjCykAxDFAcZKtQ5Q=; b=PfMckW85AvkXWfJBW4h9oDrzGv
	MfJePom3qYfNNH58Lq5F5eEJMlZLRcql3wK3aVW6knANTL3Tu587UpDf0mtSK1nrglV/tKcbd72Qt
	85iWaRwYWhqiaaBLCt3fCx0GPxqyiQEuPVs/0o8CccRKg4g1tvkKEKIBRdiMrcmLGWXvPwfuBktIX
	njNLYcAR4ZXcTJb+C1MsQ7X025epTfUk/KpbEevpxfVhOfFOp7IhZj8mK081eXYzlhpR4DCFjNSVf
	EqspPqoecZHKGLY3DrhtLY1qjZeOzU1f6SsgckSucBuPxs6zzKHaDXiROFQlWDpyxlU2Yk0keaAP2
	r1SHjV+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNN-0000000HNGR-3BGr;
	Wed, 06 Mar 2024 10:19:53 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNG-0000000HN8k-2mRD
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:49 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-Jx_1709720383;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-Jx_1709720383)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 7/9] um: Move declarations to proper headers
Date: Wed, 06 Mar 2024 18:19:23 +0800
Message-Id: <20240306101925.1088870-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021946_881194_EC8764C6 
X-CRM114-Status: GOOD (  10.89  )
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

This will address below -Wmissing-prototypes warnings:

arch/um/kernel/initrd.c:18:12: warning: no previous prototype for ‘read_initrd’ [-Wmissing-prototypes]
arch/um/kernel/um_arch.c:408:19: warning: no previous prototype for ‘read_initrd’ [-Wmissing-prototypes]
arch/um/os-Linux/start_up.c:301:12: warning: no previous prototype for ‘parse_iomem’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:15:6: warning: no previous prototype for ‘arch_switch_to’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:101:5: warning: no previous prototype for ‘poke_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_32.c:153:5: warning: no previous prototype for ‘peek_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:111:5: warning: no previous prototype for ‘poke_user’ [-Wmissing-prototypes]
arch/x86/um/ptrace_64.c:171:5: warning: no previous prototype for ‘peek_user’ [-Wmissing-prototypes]
arch/x86/um/syscalls_64.c:48:6: warning: no previous prototype for ‘arch_switch_to’ [-Wmissing-prototypes]
arch/x86/um/tls_32.c:184:5: warning: no previous prototype for ‘arch_switch_tls’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/ptrace-generic.h | 3 +++
 arch/um/include/shared/kern_util.h   | 1 +
 arch/um/kernel/physmem.c             | 3 +--
 arch/um/kernel/process.c             | 2 --
 arch/um/kernel/ptrace.c              | 3 ---
 arch/um/kernel/um_arch.h             | 2 ++
 arch/um/os-Linux/start_up.c          | 1 +
 arch/x86/um/asm/ptrace.h             | 6 ++++++
 arch/x86/um/ptrace_32.c              | 2 --
 9 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index adf91ef553ae..4696f24d1492 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -36,6 +36,9 @@ extern long subarch_ptrace(struct task_struct *child, long request,
 extern unsigned long getreg(struct task_struct *child, int regno);
 extern int putreg(struct task_struct *child, int regno, unsigned long value);
 
+extern int poke_user(struct task_struct *child, long addr, long data);
+extern int peek_user(struct task_struct *child, long addr, long data);
+
 extern int arch_set_tls(struct task_struct *new, unsigned long tls);
 extern void clear_flushed_tls(struct task_struct *task);
 extern int syscall_trace_enter(struct pt_regs *regs);
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 789b83013f35..81bc38a2e3fc 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -41,6 +41,7 @@ extern void uml_pm_wake(void);
 
 extern int start_uml(void);
 extern void paging_init(void);
+extern int parse_iomem(char *str, int *add);
 
 extern void uml_cleanup(void);
 extern void do_uml_exitcalls(void);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 91485119ae67..fb2adfb49945 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -12,6 +12,7 @@
 #include <as-layout.h>
 #include <init.h>
 #include <kern.h>
+#include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
 
@@ -161,8 +162,6 @@ __uml_setup("mem=", uml_mem_setup,
 "	Example: mem=64M\n\n"
 );
 
-extern int __init parse_iomem(char *str, int *add);
-
 __uml_setup("iomem=", parse_iomem,
 "iomem=<name>,<file>\n"
 "    Configure <file> as an IO memory region named <name>.\n\n"
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 1201c1a79b23..30bf7739ed0f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -67,8 +67,6 @@ static inline void set_current(struct task_struct *task)
 	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) { task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
-
 struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to)
 {
 	to->thread.prev_sched = from;
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 6600a2782796..2124624b7817 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -35,9 +35,6 @@ void ptrace_disable(struct task_struct *child)
 	user_disable_single_step(child);
 }
 
-extern int peek_user(struct task_struct * child, long addr, long data);
-extern int poke_user(struct task_struct * child, long addr, long data);
-
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
diff --git a/arch/um/kernel/um_arch.h b/arch/um/kernel/um_arch.h
index 1e07fb7ee35e..46e731ab9dfc 100644
--- a/arch/um/kernel/um_arch.h
+++ b/arch/um/kernel/um_arch.h
@@ -11,4 +11,6 @@ extern void __init uml_dtb_init(void);
 static inline void uml_dtb_init(void) { }
 #endif
 
+extern int __init read_initrd(void);
+
 #endif
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 8b0e98ab842c..6b21061c431c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -20,6 +20,7 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <os.h>
+#include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
 #include <registers.h>
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index 83822fd42204..2fef3da55533 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -54,6 +54,8 @@ extern int ptrace_get_thread_area(struct task_struct *child, int idx,
 extern int ptrace_set_thread_area(struct task_struct *child, int idx,
                                   struct user_desc __user *user_desc);
 
+extern int arch_switch_tls(struct task_struct *to);
+
 #else
 
 #define PT_REGS_R8(r) UPT_R8(&(r)->regs)
@@ -83,5 +85,9 @@ extern long arch_prctl(struct task_struct *task, int option,
 		       unsigned long __user *addr);
 
 #endif
+
 #define user_stack_pointer(regs) PT_REGS_SP(regs)
+
+extern void arch_switch_to(struct task_struct *to);
+
 #endif /* __UM_X86_PTRACE_H */
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 7f1abde2c84b..b0a71c6cdc6e 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -10,8 +10,6 @@
 #include <registers.h>
 #include <skas.h>
 
-extern int arch_switch_tls(struct task_struct *to);
-
 void arch_switch_to(struct task_struct *to)
 {
 	int err = arch_switch_tls(to);
-- 
2.34.1


