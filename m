Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC9C54E61
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQxBBr1sE+6cnvk9hfYk4lPa7QojIAueE3HrMfixV8Y=; b=UKLS5dtIQGgsl5fqjYIiX8rcXK
	tOaxmxwIowDTEkMRiLYBIIsaoAawOMmuL8bJ3IrahJaPxbk9qEb6NdqQKX3PN7eN4v4tOxjBRIyIE
	0eof1TiTeBS1Egr1MUek9W4yN/td/5DWbxskP975gzeKvzmmBFcl+fmm6OICxuYj40CHY7+dkHXyb
	d/0788+ndwwL/uzfvYNSHcgP21xHIl+HJD00Fw6Gay+0DgkkII1oSIxb22XDiR7wRbtU8aQI+csGH
	SLw1mnVixUnAKGZJroDNfR1+IqZ1wCKEqIVg002WeQJbAWkBly7eUGMFq75pxqz22v+vtGBFvXrim
	GhFm94fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNL-0000000HNDS-2B65;
	Wed, 06 Mar 2024 10:19:51 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNG-0000000HN8c-05bL
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:48 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-Js_1709720382;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-Js_1709720382)
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
Subject: [PATCH v3 5/9] um: Add missing headers
Date: Wed, 06 Mar 2024 18:19:21 +0800
Message-Id: <20240306101925.1088870-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021946_270783_C2EABB3A 
X-CRM114-Status: UNSURE (   7.59  )
X-CRM114-Notice: Please train this message.
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

arch/um/kernel/mem.c:202:8: warning: no previous prototype for ‘pgd_alloc’ [-Wmissing-prototypes]
arch/um/kernel/mem.c:215:7: warning: no previous prototype for ‘uml_kmalloc’ [-Wmissing-prototypes]
arch/um/kernel/process.c:207:6: warning: no previous prototype for ‘arch_cpu_idle’ [-Wmissing-prototypes]
arch/um/kernel/process.c:328:15: warning: no previous prototype for ‘arch_align_stack’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:45:6: warning: no previous prototype for ‘machine_restart’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:51:6: warning: no previous prototype for ‘machine_power_off’ [-Wmissing-prototypes]
arch/um/kernel/reboot.c:57:6: warning: no previous prototype for ‘machine_halt’ [-Wmissing-prototypes]
arch/um/kernel/skas/mmu.c:17:5: warning: no previous prototype for ‘init_new_context’ [-Wmissing-prototypes]
arch/um/kernel/skas/mmu.c:60:6: warning: no previous prototype for ‘destroy_context’ [-Wmissing-prototypes]
arch/um/kernel/skas/process.c:36:12: warning: no previous prototype for ‘start_uml’ [-Wmissing-prototypes]
arch/um/kernel/time.c:807:15: warning: no previous prototype for ‘calibrate_delay_is_known’ [-Wmissing-prototypes]
arch/um/kernel/tlb.c:594:6: warning: no previous prototype for ‘force_flush_all’ [-Wmissing-prototypes]
arch/x86/um/bugs_32.c:22:6: warning: no previous prototype for ‘arch_check_bugs’ [-Wmissing-prototypes]
arch/x86/um/bugs_32.c:44:6: warning: no previous prototype for ‘arch_examine_signal’ [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:9:6: warning: no previous prototype for ‘arch_check_bugs’ [-Wmissing-prototypes]
arch/x86/um/bugs_64.c:13:6: warning: no previous prototype for ‘arch_examine_signal’ [-Wmissing-prototypes]
arch/x86/um/elfcore.c:10:12: warning: no previous prototype for ‘elf_core_extra_phdrs’ [-Wmissing-prototypes]
arch/x86/um/elfcore.c:15:5: warning: no previous prototype for ‘elf_core_write_extra_phdrs’ [-Wmissing-prototypes]
arch/x86/um/elfcore.c:42:5: warning: no previous prototype for ‘elf_core_write_extra_data’ [-Wmissing-prototypes]
arch/x86/um/elfcore.c:63:8: warning: no previous prototype for ‘elf_core_extra_data_size’ [-Wmissing-prototypes]
arch/x86/um/fault.c:18:5: warning: no previous prototype for ‘arch_fixup’ [-Wmissing-prototypes]
arch/x86/um/os-Linux/mcontext.c:7:6: warning: no previous prototype for ‘get_regs_from_mc’ [-Wmissing-prototypes]
arch/x86/um/os-Linux/tls.c:22:6: warning: no previous prototype for ‘check_host_supports_tls’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/mem.c            | 2 ++
 arch/um/kernel/process.c        | 2 ++
 arch/um/kernel/reboot.c         | 1 +
 arch/um/kernel/skas/mmu.c       | 1 +
 arch/um/kernel/skas/process.c   | 1 +
 arch/um/kernel/time.c           | 1 +
 arch/um/kernel/tlb.c            | 1 +
 arch/x86/um/bugs_32.c           | 1 +
 arch/x86/um/bugs_64.c           | 1 +
 arch/x86/um/elfcore.c           | 1 +
 arch/x86/um/fault.c             | 1 +
 arch/x86/um/os-Linux/mcontext.c | 1 +
 arch/x86/um/os-Linux/tls.c      | 1 +
 13 files changed, 15 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579b..ca91accd64fc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -12,12 +12,14 @@
 #include <linux/slab.h>
 #include <asm/fixmap.h>
 #include <asm/page.h>
+#include <asm/pgalloc.h>
 #include <as-layout.h>
 #include <init.h>
 #include <kern.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <um_malloc.h>
 #include <linux/sched/task.h>
 
 #ifdef CONFIG_KASAN
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index a7607ef1b02f..4235e2ca2664 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -27,6 +28,7 @@
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
+#include <asm/exec.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e..25840eee1068 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/oom.h>
+#include <linux/reboot.h>
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 656fe16c9b63..aeed1c2aaf3c 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -10,6 +10,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index f2ac134c9752..fdd5922f9222 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -12,6 +12,7 @@
 #include <kern.h>
 #include <os.h>
 #include <skas.h>
+#include <kern_util.h>
 
 extern void start_kernel(void);
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index efa5b9c97992..a8bfe8be1526 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -19,6 +19,7 @@
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
+#include <linux/delay.h>
 #include <linux/time-internal.h>
 #include <linux/um_timetravel.h>
 #include <shared/init.h>
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 70b5e47e9761..8784f03fa4a6 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/sched/signal.h>
 
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <mem_user.h>
 #include <os.h>
diff --git a/arch/x86/um/bugs_32.c b/arch/x86/um/bugs_32.c
index 33daff4dade4..d29929efcc07 100644
--- a/arch/x86/um/bugs_32.c
+++ b/arch/x86/um/bugs_32.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <signal.h>
 #include <kern_util.h>
 #include <longjmp.h>
diff --git a/arch/x86/um/bugs_64.c b/arch/x86/um/bugs_64.c
index 8cc8256c698d..b01295e8a676 100644
--- a/arch/x86/um/bugs_64.c
+++ b/arch/x86/um/bugs_64.c
@@ -4,6 +4,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <sysdep/ptrace.h>
 
 void arch_check_bugs(void)
diff --git a/arch/x86/um/elfcore.c b/arch/x86/um/elfcore.c
index 650cdbbdaf45..ef50662fc40d 100644
--- a/arch/x86/um/elfcore.c
+++ b/arch/x86/um/elfcore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/elf.h>
+#include <linux/elfcore.h>
 #include <linux/coredump.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
diff --git a/arch/x86/um/fault.c b/arch/x86/um/fault.c
index 84ac7f7b0257..0dde4d613a87 100644
--- a/arch/x86/um/fault.c
+++ b/arch/x86/um/fault.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <arch.h>
 #include <sysdep/ptrace.h>
 
 /* These two are from asm-um/uaccess.h and linux/module.h, check them. */
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 49c3744cac37..e80ab7d28117 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -3,6 +3,7 @@
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
+#include <sysdep/mcontext.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
diff --git a/arch/x86/um/os-Linux/tls.c b/arch/x86/um/os-Linux/tls.c
index 3e1b1bf6acbc..eed9efe29ade 100644
--- a/arch/x86/um/os-Linux/tls.c
+++ b/arch/x86/um/os-Linux/tls.c
@@ -6,6 +6,7 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
+#include <os.h>
 #include <sysdep/tls.h>
 
 #ifndef PTRACE_GET_THREAD_AREA
-- 
2.34.1


