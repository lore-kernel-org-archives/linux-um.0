Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F41C3DA42
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pzwe5shPNzNNyXH0btr1ywKi4HXKjK7i96nQx6SUaTQ=; b=xd8Umoq5ZvCPvVSLNa8cC0r/q5
	//Onh0HMmXt2q1iytCkqy8pQXffx9MgbqdapuIF2smFfYhh78RKoCkLJ3ZHELq9eNZHkEuEOlBGuT
	sDlwKOB2xrtftDRKya7hZ2j0qGCwyGGQp7FQ2TRyHiGHdk7E4Sfe0HjA7hSc1ozE+7By1AeUAEQl9
	X2KQjt4p08kwM1Qnu+cS6QYO4Bd6FejmePzo7ymaKIR+nOW2R+fhAFSOVnsRvlj4vyLnwRc9k8wgc
	8T13hqWQigaUyYCJPkr4yumCR0e7Yzqti6/nwUkKkUhqST/rRssPFIsFpeeiH7ktJ3MZOBQR6qDLH
	8YqsHOUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TX-0000000Aae3-0TUy;
	Wed, 03 Jul 2024 15:00:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jg-0000000ALM2-1jLI
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Pzwe5shPNzNNyXH0btr1ywKi4HXKjK7i96nQx6SUaTQ=; b=BDK3v7LwizKevNTTjHve7Dd9AM
	b3C2L82slFTgVcKjEU6gge9g2FhT93EsYPExtAKEXyVlJb4eA2EoALcqMmzcO9n1Bl6Rs5An797PS
	pX5l3mBZ5/MejKX3dnWbZEsSVwmcb2KI5t9IBHYnTmgI3In+hXZ0k8eV01vF7hauq0E1PDYZ/qzbf
	KvG5YeJfArsxstsdRM0E2QsFxS+bfQL+K7tF8ghNPSFFVkCRqxn51x67Evx72MZlJ6sCELpUjr1sy
	x0Aegyt27dhKuzHZXcybXrC7zS1CIj3mBo08jmYpnojxidNTZjlZAWmh00YGTXpkFxDswAxuiNv1Q
	TuRQqUfA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jd-00000001s4J-0Kuv
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pzwe5shPNzNNyXH0btr1ywKi4HXKjK7i96nQx6SUaTQ=;
	t=1720014391; x=1721223991; b=iPbqdyYN/3cKWs6WbhsGeUJ7GjM4/msf6B0JZ9H+CHIzdKx
	q6zq3O/ONwMqHflGjSCHABr4PcaRAmGdn23NPoBPKqNx/MYs/Dm9U3I3W7fBGF1XnPHEdbO9SLcJn
	+gZLr2X4ZYLYB1vgrj6jvVgMC28BSm8p3lZheNeYbWLqxCgBh5Ek9OYqlnZekBh6GXn50pDA/dXs4
	lQEQmvUmq5LmvKOkgjpw/4jgDuQxfNX21M3YctWQwolyuTeCzcKGpbZQDczn6l6Fbm4eL6idHryGo
	DmhowL6Q08W70ascKt9d467KvmVrOX+RwMR5YdoOdi+3xRRRZnEjLSSKFJarb8VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JY-000000094nb-2qGt;
	Wed, 03 Jul 2024 15:46:29 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 10/12] um: remove force_flush_all from fork_handler
Date: Wed,  3 Jul 2024 15:45:34 +0200
Message-ID: <20240703134536.1161108-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144633_124080_6CEF2D24 
X-CRM114-Status: GOOD (  14.95  )
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
 arch/um/kernel/tlb.c              | 44 +++++++++++--------------------
 3 files changed, 15 insertions(+), 33 deletions(-)

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
index 79f41f06a98f..f36b63f53bab 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -122,8 +122,6 @@ void new_thread_handler(void)
 /* Called magically, see new_thread_handler above */
 static void fork_handler(void)
 {
-	force_flush_all();
-
 	schedule_tail(current->thread.prev_sched);
 
 	/*
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 1eee7134cba8..4f482b881adc 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -41,17 +41,15 @@ struct host_vm_change {
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
@@ -235,7 +233,7 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 		prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
 			(x ? UM_PROT_EXEC : 0));
-		if (hvc->force || pte_newpage(*pte)) {
+		if (pte_newpage(*pte)) {
 			if (pte_present(*pte)) {
 				if (pte_newpage(*pte))
 					ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
@@ -261,7 +259,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
-			if (hvc->force || pmd_newpage(*pmd)) {
+			if (pmd_newpage(*pmd)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				pmd_mkuptodate(*pmd);
 			}
@@ -283,7 +281,7 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
-			if (hvc->force || pud_newpage(*pud)) {
+			if (pud_newpage(*pud)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				pud_mkuptodate(*pud);
 			}
@@ -305,7 +303,7 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(*p4d)) {
-			if (hvc->force || p4d_newpage(*p4d)) {
+			if (p4d_newpage(*p4d)) {
 				ret = add_munmap(addr, next - addr, hvc);
 				p4d_mkuptodate(*p4d);
 			}
@@ -316,19 +314,19 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
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
@@ -349,11 +347,11 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
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
@@ -537,7 +535,7 @@ void __flush_tlb_one(unsigned long addr)
 }
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
-		      unsigned long end_addr, int force)
+		      unsigned long end_addr)
 {
 	/*
 	 * Don't bother flushing if this address space is about to be
@@ -546,7 +544,7 @@ static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 	if (atomic_read(&mm->mm_users) == 0)
 		return;
 
-	fix_range_common(mm, start_addr, end_addr, force);
+	fix_range_common(mm, start_addr, end_addr);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -554,7 +552,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 {
 	if (vma->vm_mm == NULL)
 		flush_tlb_kernel_range_common(start, end);
-	else fix_range(vma->vm_mm, start, end, 0);
+	else fix_range(vma->vm_mm, start, end);
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
@@ -564,17 +562,5 @@ void flush_tlb_mm(struct mm_struct *mm)
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
2.45.2


