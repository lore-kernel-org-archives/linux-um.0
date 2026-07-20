Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F2C44530
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WhdL3FJY/vrUjM1Ql6morukiStYtwnJEKtLRpl2jO28=; b=n9hdhUQXAR/APjDUk8Ep8Ut9d2
	Aoh+S8ETyUkLS6b1sb/GT7aHQ9l4gLJIg/jvHg7Mfdgls4J6CEDP3q0GCyiGCt4y1KOaMKUuHucix
	ouTHVs8J5Wlk1mY7MC6HhvRYHiBtf3hGrzxyis0hhIPlokpWNwnoGIVY6KSs6OOM6bbxV5dzU8gy0
	0AfKBlEQf5x7N29DiLVe5Hdzc/VlZPjRy9wOeknR9tIspm0P+BubN+El8Y2QDGM/PVMbxwq0OOG76
	cLY+KoOmqHBO5KQeKvq6BRFFUKlXhnjs5YrFCgXn4ZZBZgzAWNps7nCE3oyb3o6T65uCPvHcLWCKa
	Pb3FFCuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5I-00000007h84-0A52;
	Mon, 20 Jul 2026 18:51:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5A-00000007h18-0LEM
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WhdL3FJY/vrUjM1Ql6morukiStYtwnJEKtLRpl2jO28=;
	t=1784573475; x=1785783075; b=xtKjE3vee2avf6jYyAtjzgMtvtiuAUEgYbgLYtCbbjtGaKW
	u/dF65n9bzpCgM7dYw/ozKQS/0fmIEktLsnWdY2lFW17NFKBAFnpLnQjFFRTHAXrJsT0fDi0GMzkW
	KAySBsvTFMePt9ZcNW21A1c+MvLZLZr49w81m/EtaMhUwffmVsE7gnIakmwzHAcnekppiEQ8VazVX
	4bpphPLNcMhHC8Mk/ymZ83VfPm6NyBns2ms3YhH8t+zvRA1usF5bDXOGfmGtvjFZVagb36MevpaHY
	uMrCjmmUYfJCzaobpY2EntcFd/hGgbo+CQLeo5FYsyOEk/sOBLxXZ4hZJG+PsOAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt57-0000000GsPP-39xt;
	Mon, 20 Jul 2026 20:51:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 8/9] um: nommu: add userspace runner processes
Date: Mon, 20 Jul 2026 20:26:58 +0200
Message-ID: <20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115116_123408_8D96F7AF 
X-CRM114-Status: GOOD (  20.84  )
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

From: Johannes Berg <johannes.berg@intel.com>

For NOMMU there are not separate address spaces for
each userspace process group, which on the one hand
means we cannot start them on demand, but on the
other means we can just have one for each (virtual)
CPU, and map all of the memory into them.

Implement such processes, and the remaining bits
needed to compile the kernel without CONFIG_MMU.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/Makefile      |  3 ++
 arch/um/kernel/skas/Makefile |  3 ++
 arch/um/kernel/skas/nommu.c  | 91 ++++++++++++++++++++++++++++++++++++
 arch/um/kernel/smp.c         |  3 +-
 arch/um/kernel/time.c        |  3 +-
 arch/um/kernel/trap-nommu.c  | 13 ++++++
 6 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/kernel/skas/nommu.c
 create mode 100644 arch/um/kernel/trap-nommu.c

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5cd1bd4b23ac..b087b4278173 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -20,6 +20,9 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	um_arch.o umid.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
 obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o trap-mmu.o
+ifneq ($(CONFIG_MMU),y)
+obj-y += trap-nommu.o
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 28dd33580abc..c098d087c3f2 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -6,6 +6,9 @@
 obj-y := stub.o process.o syscall.o \
 	 stub_exe_embed.o
 obj-$(CONFIG_MMU) += mmu.o uaccess.o
+ifneq ($(CONFIG_MMU),y)
+obj-y += nommu.o
+endif
 
 # Stub executable
 
diff --git a/arch/um/kernel/skas/nommu.c b/arch/um/kernel/skas/nommu.c
new file mode 100644
index 000000000000..80d5c4eaa96b
--- /dev/null
+++ b/arch/um/kernel/skas/nommu.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/mutex.h>
+#include <linux/panic.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <as-layout.h>
+#include <mem.h>
+#include <os.h>
+#include <skas.h>
+#include <mm_id.h>
+
+struct nommu_runner {
+	struct mm_id mm_id;
+	struct mutex turnstile;
+};
+
+static struct nommu_runner nommu_runners[NR_CPUS];
+
+static struct nommu_runner *this_runner(void)
+{
+	return &nommu_runners[raw_smp_processor_id()];
+}
+
+struct mutex *__get_turnstile(struct mm_id *mm_id)
+{
+	return &container_of(mm_id, struct nommu_runner, mm_id)->turnstile;
+}
+
+void enter_turnstile(struct mm_id *mm_id)
+{
+	mutex_lock(__get_turnstile(mm_id));
+}
+
+void exit_turnstile(struct mm_id *mm_id)
+{
+	mutex_unlock(__get_turnstile(mm_id));
+}
+
+unsigned long current_stub_stack(void)
+{
+	return this_runner()->mm_id.stack;
+}
+
+struct mm_id *current_mm_id(void)
+{
+	return &this_runner()->mm_id;
+}
+
+void current_mm_sync(void)
+{
+}
+
+static int __init nommu_start_runners(void)
+{
+	unsigned long long offset;
+	struct nommu_runner *r;
+	int cpu, err, fd;
+
+	fd = phys_mapping(uml_reserved - uml_physmem, &offset);
+
+	for_each_possible_cpu(cpu) {
+		r = &nommu_runners[cpu];
+		mutex_init(&r->turnstile);
+
+		r->mm_id.stack = __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  ilog2(STUB_DATA_PAGES));
+		if (!r->mm_id.stack)
+			panic("OOM allocating userspace stack for CPU %d", cpu);
+
+		err = start_userspace(&r->mm_id);
+		if (err < 0)
+			panic("userspace startup for CPU %d failed: %d",
+			      cpu, err);
+
+		map(&r->mm_id, uml_reserved, high_physmem - uml_reserved,
+		    UM_PROT_READ | UM_PROT_WRITE | UM_PROT_EXEC, fd, offset);
+
+		err = syscall_stub_flush(&r->mm_id);
+		if (err < 0)
+			panic("physmem map/flush failed for CPU%d: %d",
+			      cpu, err);
+	}
+
+	return 0;
+}
+arch_initcall(nommu_start_runners);
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
index f1e52b7348fb..92ea1beaed8b 100644
--- a/arch/um/kernel/smp.c
+++ b/arch/um/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <init.h>
 #include <kern.h>
 #include <os.h>
+#include <skas.h>
 #include <smp.h>
 
 enum {
@@ -66,7 +67,7 @@ static void ipi_handler(int vector, struct uml_pt_regs *regs)
 	irq_enter();
 
 	if (current->mm)
-		os_alarm_process(current->mm->context.id.pid);
+		os_alarm_process(current_mm_id()->pid);
 
 	switch (vector) {
 	case UML_IPI_RES:
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index b344a36b44eb..d620b6d6310a 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -19,6 +19,7 @@
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
+#include <skas.h>
 #include <linux/delay.h>
 #include <linux/time-internal.h>
 #include <linux/um_timetravel.h>
@@ -873,7 +874,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL &&
 	    get_current()->mm)
-		os_alarm_process(get_current()->mm->context.id.pid);
+		os_alarm_process(current_mm_id()->pid);
 
 	evt->event_handler(evt);
 
diff --git a/arch/um/kernel/trap-nommu.c b/arch/um/kernel/trap-nommu.c
new file mode 100644
index 000000000000..891a9cefa935
--- /dev/null
+++ b/arch/um/kernel/trap-nommu.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <shared/kern_util.h>
+
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	/* everything that's valid is already mapped in NOMMU */
+	*code_out = SEGV_MAPERR;
+	return -EFAULT;
+}
-- 
2.53.0


