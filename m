Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCBFF506D2
	for <linux-um@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qNTRboQnFOzEcDZWjE5gbTfa/sTE7nhGfdbNQAdviM=; b=PItb67dxUN7s30OxMUKvHxwGsH
	uYDXSebEzEK9/m47uk2XSoLU6k3eGINS2dxrgcDFQYUcNCgCjyy1eQbxrdcJmwDBP4nrFalVwtXG7
	miJLixGRfviF7uIzJZ43HLqZvriLLSrJClaM9Cog0tbI5slzZzXAodHPSngP3LmsUJeOUeK+PksNm
	rahk4rPm6Aw2KCBgFpvXk8hILbI7nBDWyRSqmqUMsIe1qtCqHFFBZq833rZgzjNkAtOXph/vPQGq3
	RYtYYmxMwq3BSrzPS7zlmQSUDZsnT0r/d1lGvj7TB3aDo1Iox4OSobiPhaHVRSiLau9EYkmspDu+c
	030ATyqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27hA-000000040jz-45Qs;
	Mon, 16 Mar 2026 13:09:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27h6-000000040cZ-1wKK;
	Mon, 16 Mar 2026 13:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2qNTRboQnFOzEcDZWjE5gbTfa/sTE7nhGfdbNQAdviM=; b=RB81Qvh2ctYMU4unqh71DHXHM6
	UgMWWOmuMLGTHSv6KVSrnX7qJSvyB+U8DDTWXx1E8Eoh+PKCaCPrQUWBNm0JxZETLCbduyt4uZsYM
	jZ8cDr0fCHcUJsDOrU4N0/XGcXPHSSTyZFoA2sWf3sXTznHHg/qXxEi4MAgCKaJt2vrC8gI521oBR
	CROKOQ9SRVo+ZS/FD4RVs+kMZqSSnP/wDcIJl98v/A4CwJtRef6CXKCOfN9cA2GZLJP4FjJKxYd+7
	rgxSMn4yD4Z+ktYAesqr+AsGFfEeH4S08eESJANrHRXAsN0CE3P+WquirP+9wJmg8NM1vHtY/J+RJ
	6cxPrLnA==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27h1-00000006lTp-2u1Q;
	Mon, 16 Mar 2026 13:09:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C2D6240E2A;
	Mon, 16 Mar 2026 13:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F7CC19421;
	Mon, 16 Mar 2026 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666548;
	bh=dFX8i/GTSiNIxM80Lt/6wl8nx+eQNgs3hUpoH1nEJn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMFk18smoAUK8/iQkecF/D+k4Fm8bjm4Y62bOngadQJFJO1eJVtoUoR5yvb3TpnvH
	 ItcJfNDFkaS1hwr4umR0dz77y2yJonPNOkkbygIC+3M31JRdxx3KLCvdl3UDA/zZ6K
	 L+0cwUopOhiHs4KgH7ynZ8pIwu1Tp3n8f32OxxH7D7bd8n8pwBMzux42iD1c1g0IS4
	 uV6AtCA6ZBPSvitBDr2wuTXw9nkPvQbhj5g2jSmtki81HIxoFhtbkfIqpdmkHCWhpS
	 AGs8UgsjIrqKTJRrPvT1zGlgYCd0YWmkxw2g4T75jcce9dXreobooxdi2hl2Y/gEKb
	 0AtmwCo/kr82Q==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 05/23] mm/vma: use new VMA flags for sticky flags logic
Date: Mon, 16 Mar 2026 13:07:54 +0000
Message-ID: <005cac3e37830a33f473edc780a5dae5e00a3845.1773665966.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_130912_091994_B6EC6B88 
X-CRM114-Status: GOOD (  20.39  )
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

Use the new vma_flags_t flags implementation to perform the logic around
sticky flags and what flags are ignored on VMA merge.

We make use of the new vma_flags_empty(), vma_flags_diff_pair(), and
vma_flags_and_mask() functionality.

Note that we cannot rely on VM_NONE convenience any longer, so have to
explicitly check for cases where VMA flags would not be specified.

Also update the VMA tests accordingly.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 32 +++++++++++---------
 mm/vma.c                           | 47 ++++++++++++++++++++++--------
 tools/testing/vma/include/custom.h |  5 ----
 tools/testing/vma/include/dup.h    |  9 ++++--
 4 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6d2c4bd2c61d..b75e089dfd65 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -540,6 +540,7 @@ enum {
 
 /* VMA basic access permission flags */
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+#define VMA_ACCESS_FLAGS mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT)
 
 /*
  * Special vmas that are non-mergable, non-mlock()able.
@@ -585,27 +586,32 @@ enum {
  * possesses it but the other does not, the merged VMA should nonetheless have
  * applied to it:
  *
- *   VM_SOFTDIRTY - if a VMA is marked soft-dirty, that is has not had its
- *                  references cleared via /proc/$pid/clear_refs, any merged VMA
- *                  should be considered soft-dirty also as it operates at a VMA
- *                  granularity.
+ *   VMA_SOFTDIRTY_BIT - if a VMA is marked soft-dirty, that is has not had its
+ *                       references cleared via /proc/$pid/clear_refs, any
+ *                       merged VMA should be considered soft-dirty also as it
+ *                       operates at a VMA granularity.
  *
- * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
- *                  mapped page tables may contain metadata not described by the
- *                  VMA and thus any merged VMA may also contain this metadata,
- *                  and thus we must make this flag sticky.
+ * VMA_MAYBE_GUARD_BIT - If a VMA may have guard regions in place it implies
+ *                       that mapped page tables may contain metadata not
+ *                       described by the VMA and thus any merged VMA may also
+ *                       contain this metadata, and thus we must make this flag
+ *                       sticky.
  */
-#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define VMA_STICKY_FLAGS mk_vma_flags(VMA_SOFTDIRTY_BIT, VMA_MAYBE_GUARD_BIT)
+#else
+#define VMA_STICKY_FLAGS mk_vma_flags(VMA_MAYBE_GUARD_BIT)
+#endif
 
 /*
  * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
  * of these flags and the other not does not preclude a merge.
  *
- *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
- *                'sticky'. If any sticky flags exist in either VMA, we simply
- *                set all of them on the merged VMA.
+ *    VMA_STICKY_FLAGS - When merging VMAs, VMA flags must match, unless they
+ *                       are 'sticky'. If any sticky flags exist in either VMA,
+ *                       we simply set all of them on the merged VMA.
  */
-#define VM_IGNORE_MERGE VM_STICKY
+#define VMA_IGNORE_MERGE_FLAGS VMA_STICKY_FLAGS
 
 /*
  * Flags which should result in page tables being copied on fork. These are
diff --git a/mm/vma.c b/mm/vma.c
index 4d21e7d8e93c..15d643eee97f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -86,10 +86,15 @@ static bool vma_is_fork_child(struct vm_area_struct *vma)
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
+	vma_flags_t diff;
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
+
+	diff = vma_flags_diff_pair(&vma->flags, &vmg->vma_flags);
+	vma_flags_clear_mask(&diff, VMA_IGNORE_MERGE_FLAGS);
+
+	if (!vma_flags_empty(&diff))
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -805,7 +810,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
-	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
+	vma_flags_t sticky_flags = vma_flags_and_mask(&vmg->vma_flags,
+						      VMA_STICKY_FLAGS);
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -898,15 +904,21 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	vma_start_write(middle);
 
 	if (merge_right) {
+		const vma_flags_t next_sticky =
+			vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
+
 		vma_start_write(next);
 		vmg->target = next;
-		sticky_flags |= (next->vm_flags & VM_STICKY);
+		vma_flags_set_mask(&sticky_flags, next_sticky);
 	}
 
 	if (merge_left) {
+		const vma_flags_t prev_sticky =
+			vma_flags_and_mask(&prev->flags, VMA_STICKY_FLAGS);
+
 		vma_start_write(prev);
 		vmg->target = prev;
-		sticky_flags |= (prev->vm_flags & VM_STICKY);
+		vma_flags_set_mask(&sticky_flags, prev_sticky);
 	}
 
 	if (merge_both) {
@@ -976,7 +988,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	vm_flags_set(vmg->target, sticky_flags);
+	vma_set_flags_mask(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1154,7 +1166,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
 	bool remove_next = false;
-	vm_flags_t sticky_flags;
+	vma_flags_t sticky_flags =
+		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
+	const vma_flags_t target_sticky =
+		vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
 	int ret = 0;
 
 	mmap_assert_write_locked(vmg->mm);
@@ -1174,10 +1189,13 @@ int vma_expand(struct vma_merge_struct *vmg)
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
-	sticky_flags = vmg->vm_flags & VM_STICKY;
-	sticky_flags |= target->vm_flags & VM_STICKY;
-	if (remove_next)
-		sticky_flags |= next->vm_flags & VM_STICKY;
+	vma_flags_set_mask(&sticky_flags, target_sticky);
+	if (remove_next) {
+		const vma_flags_t next_sticky =
+			vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
+
+		vma_flags_set_mask(&sticky_flags, next_sticky);
+	}
 
 	/*
 	 * If we are removing the next VMA or copying from a VMA
@@ -1200,7 +1218,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
-	vm_flags_set(target, sticky_flags);
+	vma_set_flags_mask(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1950,10 +1968,15 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
  */
 static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
 {
+	vma_flags_t diff = vma_flags_diff_pair(&a->flags, &b->flags);
+
+	vma_flags_clear_mask(&diff, VMA_ACCESS_FLAGS);
+	vma_flags_clear_mask(&diff, VMA_IGNORE_MERGE_FLAGS);
+
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
+		vma_flags_empty(&diff) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 6200f938e586..7cdd0f60600a 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -134,8 +134,3 @@ static __always_inline bool vma_flags_same_mask(vma_flags_t *flags,
 	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 #define VMA_SPECIAL_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_DONTEXPAND_BIT, \
 				       VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT)
-#ifdef CONFIG_MEM_SOFT_DIRTY
-#define VMA_STICKY_FLAGS mk_vma_flags(VMA_SOFTDIRTY_BIT, VMA_MAYBE_GUARD_BIT)
-#else
-#define VMA_STICKY_FLAGS mk_vma_flags(VMA_MAYBE_GUARD_BIT)
-#endif
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 44f77453ee85..e5fdf6f5a033 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -338,6 +338,7 @@ enum {
 
 /* VMA basic access permission flags */
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+#define VMA_ACCESS_FLAGS mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT)
 
 /*
  * Special vmas that are non-mergable, non-mlock()able.
@@ -363,9 +364,13 @@ enum {
 
 #define CAP_IPC_LOCK         14
 
-#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define VMA_STICKY_FLAGS mk_vma_flags(VMA_SOFTDIRTY_BIT, VMA_MAYBE_GUARD_BIT)
+#else
+#define VMA_STICKY_FLAGS mk_vma_flags(VMA_MAYBE_GUARD_BIT)
+#endif
 
-#define VM_IGNORE_MERGE VM_STICKY
+#define VMA_IGNORE_MERGE_FLAGS VMA_STICKY_FLAGS
 
 #define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
 
-- 
2.53.0


