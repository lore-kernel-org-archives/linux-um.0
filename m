Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC50CE7A89
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JOv9WiB+C27vxeTDFw0vHOIZogvKUD6BMnyP7uB9m28=; b=q9IC/D0ZXNl6Sb
	/F6XQ4TZC7nEsHrwhcT/y7Kk8h+hM9wCBTJSYngKJDOmg0lxIy+3LhIyyRZOYOFsqjt3YzHAqTCVT
	57GViVvp4ePgYYN5C6ISN2vyxFoNdOMa7j+ZC8JA5e1Ivk27b+AW1xrl1D55YxHZwlFH70nKHcQOp
	Q6IWdB3n3SpjOcBmE6rcC96UzddvtKEe63z8eWzMo1gYL+s9fzk6cJ17RzHQPjtKyx9N1uEqewtn2
	d+dBRaNm0Gil1KxjrdbUre5yLV8n2KMO1D8XjTiwnunK9AU21AyCopL3hwhSeMyrpF+0QOfsSBk+D
	L9OOkHA4Gv4i0xC6ItTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo9-009vYj-0v;
	Fri, 22 Sep 2023 22:39:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo2-009vWM-2Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 22:39:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kEwXZHPisBHr3NbWodnXmnPjGrHOUdXL7gyyIHy/vOw=;
	t=1695422366; x=1696631966; b=V2cZterlPBypqsn86UEmcGjcGI7B82viPLFRCVvtnPsDNlc
	jqm4sNOeEn55/cOBuHDItXvKij6X1W/b8kvXUkN4qZx4AKD00wDpEMZ3T2eb4NGsIHVKfsib0uAnA
	54tZugnLoLsySmkC7moVuEYWFDdOx8k/RKTU1ANcPKnpWNh1ZImHOTmaJx7tQ87OxIHolqlpVrec5
	FGKUxgbjpvaH10ir+UDkuUO6/nhLwsIS+XsGKbjpOaejqPoyun8j2HKNl4BWT1+bf9bBTO9FSAEf8
	duAEjJglCPZ9pa5aALOnv/nCIW3iVtj1IEWU911nmWWuvUhtaNiNpaFgTbs4LA3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjonz-00FtWi-0R;
	Sat, 23 Sep 2023 00:39:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 3/3] um: don't force-flush in mm/userspace process start
Date: Sat, 23 Sep 2023 00:37:41 +0200
Message-ID: <20230923003737.0bfe4730802e.I479958276048d012396d29bab539588094d74010@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922223737.1206223-4-johannes@sipsolutions.net>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_153926_886403_6A52683C 
X-CRM114-Status: GOOD (  16.71  )
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

From: Johannes Berg <johannes.berg@intel.com>

The reason to flush here is to resynchronize the mm after
a copy. For exec we don't need to since flush_thread()
will anyway clear everything.

Thus, we can just do this in arch_dup_mmap(), since when
that's invoked, the new mm has been setup sufficiently.
This isn't true if we just flush in init_new_context().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/Kbuild        |  1 -
 arch/um/include/asm/mm_hooks.h    | 22 ++++++++++++++++++++++
 arch/um/include/asm/mmu_context.h |  2 +-
 arch/um/kernel/process.c          |  2 --
 arch/um/kernel/skas/mmu.c         |  7 +++++++
 arch/um/kernel/tlb.c              |  5 +----
 6 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 arch/um/include/asm/mm_hooks.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a..de8d82a6fd7b 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,5 +26,4 @@ generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += kprobes.h
-generic-y += mm_hooks.h
 generic-y += vga.h
diff --git a/arch/um/include/asm/mm_hooks.h b/arch/um/include/asm/mm_hooks.h
new file mode 100644
index 000000000000..b1016520c5b8
--- /dev/null
+++ b/arch/um/include/asm/mm_hooks.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_MM_HOOKS_H
+#define _ASM_UM_MM_HOOKS_H
+
+int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm);
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	/* by default, allow everything */
+	return true;
+}
+#endif	/* _ASM_UM_MM_HOOKS_H */
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 68e2eb9cfb47..8668861d4a85 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,7 +13,7 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-extern void force_flush_all(void);
+void force_flush_all(struct mm_struct *mm);
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6daffb9d8a8d..d7545ba6522a 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -139,8 +139,6 @@ void new_thread_handler(void)
 /* Called magically, see new_thread_handler above */
 void fork_handler(void)
 {
-	force_flush_all();
-
 	schedule_tail(current->thread.prev_sched);
 
 	/*
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index ea0c37b92581..97e731180f70 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -10,6 +10,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
@@ -69,6 +70,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	return ret;
 }
 
+int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	force_flush_all(mm);
+	return 0;
+}
+
 void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 34ec8e677fb9..7c0161321fd9 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -600,14 +600,11 @@ void flush_tlb_mm(struct mm_struct *mm)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
 }
 
-void force_flush_all(void)
+void force_flush_all(struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
-	mmap_read_lock(mm);
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-	mmap_read_unlock(mm);
 }
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
