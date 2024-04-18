Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1036C05052
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXigasBLPYw9UvvHud1UMYjBllTNiVgifvAAbw3YvH4=; b=tOCh424vBzMoDP2JETDU+ULvPK
	kQ2j608//yawAaU+diPWVJG1iMTTcV2/l6byIUjzd4G94UmvdWG6vQ+4eowNDq7DaFU3P6ijrMjKc
	PyDF96KGZpSh6MwOROx6Vg7hExIxqARx3clRxXAZZyfx6CODMmks4pVn+kpEtHSK1DYz4A1eJxAgs
	B7fYmEM1LTfRLu6CEvWg5jFWSydjHQO8NLF2KZJIO70Gh8O7fxCaN04fpyAEqQFofcsZF1JMa+0MJ
	eHdx7zTewL/4lu8xcP6YYA1TQ5IO8r4Ch4d6bQQYzQL2LiDqT1uR0De6W17m0t8viD1Z/5pU1ciul
	2TCJ6qLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0z-00000001bSv-46vj;
	Thu, 18 Apr 2024 09:25:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0q-00000001bIl-3C1k
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zXigasBLPYw9UvvHud1UMYjBllTNiVgifvAAbw3YvH4=;
	t=1713432300; x=1714641900; b=Q0Q4B5zAddDgpaTjza75kX7GEXnznfadEYKgQmhTNlNFZjF
	0Z9o6mwJo8BBnr5FZngOWccT6OFCVt+t863bmTLsJJe6I8jF4KIMXau2LEX0KrFVek6rn2BTVXjsj
	rsblJObVeED1u3znIPr20RJOWwkqvpVb1iVtJSyRvDAq6OGiTOh5RN8idyuslTRSuaM7/NKPNE5W1
	jBAnbeqo9PvZheMl47EJBdID2EOZGmO59koP9cF0VYXIBhqKVKRghDDgutB5vKR+OyjIZKxoHXIrq
	JOs1Ul5/a52tiohK+JwqSilgQ6lx0JoYOsp4RytpuxiG+KhcHJa5dyehkmEBAlZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0p-0000000CKXH-03js;
	Thu, 18 Apr 2024 11:24:59 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 10/12] um: remove force_flush_all from fork_handler
Date: Thu, 18 Apr 2024 11:23:25 +0200
Message-ID: <20240418092327.860135-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022501_013918_DD5A926D 
X-CRM114-Status: GOOD (  15.58  )
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

There should be no need for this. It may be that this used to work
around another issue where after a clone the MM was in a bad state.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/asm/mmu_context.h |  2 --
 arch/um/kernel/process.c          |  2 --
 arch/um/kernel/tlb.c              | 46 +++++++++++--------------------
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 68e2eb9cfb47..23dcc914d44e 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,8 +13,6 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-extern void force_flush_all(void);
-
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index ab95648e93e1..390bf711fbd1 100644
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
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 391c98137890..f183a9b9ff7b 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -40,17 +40,15 @@ struct host_vm_change {
 	int index;
 	struct mm_struct *mm;
 	void *data;
-	int force;
 };
 
-#define INIT_HVC(mm, force, userspace) \
+#define INIT_HVC(mm, userspace) \
 	((struct host_vm_change) \
 	 { .ops		= { { .type = NONE } },	\
 	   .mm		= mm, \
        	   .data	= NULL, \
 	   .userspace	= userspace, \
-	   .index	= 0, \
-	   .force	= force })
+	   .index	= 0 })
 
 void report_enomem(void)
 {
@@ -234,7 +232,7 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 		prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
 			(x ? UM_PROT_EXEC : 0));
-		if (hvc->force || pte_newpage(*pte)) {
+		if (pte_newpage(*pte)) {
 			if (pte_present(*pte)) {
 				if (pte_newpage(*pte))
 					ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
@@ -260,7 +258,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
-			if (hvc->force || pmd_newpage(*pmd)) {
+			if (pmd_newpage(*pmd)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				pmd_mkuptodate(*pmd);
 			}
@@ -282,7 +280,7 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
-			if (hvc->force || pud_newpage(*pud)) {
+			if (pud_newpage(*pud)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				pud_mkuptodate(*pud);
 			}
@@ -304,7 +302,7 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(*p4d)) {
-			if (hvc->force || p4d_newpage(*p4d)) {
+			if (p4d_newpage(*p4d)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				p4d_mkuptodate(*p4d);
 			}
@@ -315,19 +313,19 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 }
 
 static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-			     unsigned long end_addr, int force)
+			     unsigned long end_addr)
 {
 	pgd_t *pgd;
 	struct host_vm_change hvc;
 	unsigned long addr = start_addr, next;
 	int ret = 0, userspace = 1;
 
-	hvc = INIT_HVC(mm, force, userspace);
+	hvc = INIT_HVC(mm, userspace);
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end_addr);
 		if (!pgd_present(*pgd)) {
-			if (force || pgd_newpage(*pgd)) {
+			if (pgd_newpage(*pgd)) {
 				ret = add_munmap(addr, next - addr, &hvc);
 				pgd_mkuptodate(*pgd);
 			}
@@ -348,11 +346,11 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long addr, last;
-	int updated = 0, err = 0, force = 0, userspace = 0;
+	int updated = 0, err = 0,  userspace = 0;
 	struct host_vm_change hvc;
 
 	mm = &init_mm;
-	hvc = INIT_HVC(mm, force, userspace);
+	hvc = INIT_HVC(mm, userspace);
 	for (addr = start; addr < end;) {
 		pgd = pgd_offset(mm, addr);
 		if (!pgd_present(*pgd)) {
@@ -536,7 +534,7 @@ void __flush_tlb_one(unsigned long addr)
 }
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
-		      unsigned long end_addr, int force)
+		      unsigned long end_addr)
 {
 	/*
 	 * Don't bother flushing if this address space is about to be
@@ -545,7 +543,7 @@ static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 	if (atomic_read(&mm->mm_users) == 0)
 		return;
 
-	fix_range_common(mm, start_addr, end_addr, force);
+	fix_range_common(mm, start_addr, end_addr);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -553,14 +551,14 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 {
 	if (vma->vm_mm == NULL)
 		flush_tlb_kernel_range_common(start, end);
-	else fix_range(vma->vm_mm, start, end, 0);
+	else fix_range(vma->vm_mm, start, end);
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end)
 {
-	fix_range(mm, start, end, 0);
+	fix_range(mm, start, end);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -569,17 +567,5 @@ void flush_tlb_mm(struct mm_struct *mm)
 	VMA_ITERATOR(vmi, mm, 0);
 
 	for_each_vma(vmi, vma)
-		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-}
-
-void force_flush_all(void)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma)
-		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-	mmap_read_unlock(mm);
+		fix_range(mm, vma->vm_start, vma->vm_end);
 }
-- 
2.44.0


