Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580D11099B35
	for <linux-um@archiver.kernel.org>; Fri, 20 Mar 2026 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZN40bzOwgfP54d8m0LVPICl9RFWnuWTvuCipJbm/ec=; b=rSjstxdhapgIPz+731BXpUqdox
	qhe5hRA3u4SHCwtf4jFHivi82f03tATZBjGy91jMxgHaHmCe/tGI/FnF4YeJ0t/Lpb7FJHBeQ9gMw
	+nsLBjX/zFS/kAssATFqboHhTQ93tsggTs5WV/K8BEA+YvcupRxfAhlBLvPwZlYKJvYIlfRRzQ+V7
	Kq6F3mdvBzjrdI4ht8UUe4cpKoM0zwJI63UgVCySbOjL4inCO0R/xFERHplQOnrQyAdLLzNfHO1Zv
	bjMUi0Ys+S84bVa9Q6dwBwl7rM10HMKAdzK0W3gr7BMKOnywRQQdflFoth7++Mqt7dmmrJfjWl7i0
	GaX8h//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fh6-0000000DU5L-35TV;
	Fri, 20 Mar 2026 19:39:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fgs-0000000DThD-3Ycm;
	Fri, 20 Mar 2026 19:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dZN40bzOwgfP54d8m0LVPICl9RFWnuWTvuCipJbm/ec=; b=pzAZTaC4D0dWf3mkYnzXTP5APJ
	RXWW3+SnXZkFJhu8/lBlMyiEk9GicAiPQA6UsflvBnQrcg/u0HYltioXFzdWuJ2yy6u+7HWDdF88v
	zl+tfyG43LYm9zbXKIiYVJld/0Bf3Wy70rwvCpc7KlRr0teXWUlK0R+QAtLxOvz76G9Gui389xllq
	L6gpIhJvym84NAVQkfSLG1UqcXTKQLJOA6KWVZodZSn0JJJx/H+Ie1ptU7GrwyEEYJsIIlfV+vaD+
	yHHvgsQ7v0WVzxnuZClMuRy9SXWeXNhFTIWrDqFCRwlNUCTx36oj1Dkp8CZ11ivE7Mo2Xv/51U46D
	XCEKtP4Q==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fgo-0000000GMFf-02kB;
	Fri, 20 Mar 2026 19:39:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EE8A416D3;
	Fri, 20 Mar 2026 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE33FC4CEF7;
	Fri, 20 Mar 2026 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035560;
	bh=frZGbChHfZDBR7/pCN2wWxe44RSqCYtYg/5HJ8X7rnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX82bPEa9dczbYZwn6vfhbeDK+Ajku+xA9x1MdDEsvLROP2EOfKP+e+ANeFkz5xMy
	 OclEVmr33n+GqODBneGwuAlRCKiBQxo8WWqOYcdaJ0YNQOauhqIvhCCfI93kQ8a46t
	 KIq0Ur5WXfClxDm8st4KHFzoN13nG4Ib+X8KOcASJfZyeyKJ8J09cIFVUNhA5Ky5Kf
	 ixa08AIO4H+20X7qSKi4d7M9BaJbUJjkqKcNoQKgCcQCqDUz9SwTHZoO3X0dOZstu5
	 8a4GUv7HoIOWTOUPClkpq7+CPWVvfFpqdnmoqDEyyR6CSVjvESquXJk3FWcSTB3Ftg
	 wSjHWNf9uxzBQ==
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
Subject: [PATCH v4 15/25] mm: introduce vma_flags_count() and vma[_flags]_test_single_mask()
Date: Fri, 20 Mar 2026 19:38:32 +0000
Message-ID: <cd778dd02b9f2a01eb54d25a49dea8ec2ddf7753.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_193922_418472_9CDD7D63 
X-CRM114-Status: GOOD (  20.02  )
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

vma_flags_count() determines how many bits are set in VMA flags, using
bitmap_weight().

vma_flags_test_single_mask() determines if a vma_flags_t set of flags
contains a single flag specified as another vma_flags_t value, or if the
sought flag mask is empty, it is defined to return false.

This is useful when we want to declare a VMA flag as optionally a single
flag in a mask or empty depending on kernel configuration.

This allows us to have VM_NONE-like semantics when checking whether the
flag is set.

In a subsequent patch, we introduce the use of VMA_DROPPABLE of type
vma_flags_t using precisely these semantics.

It would be actively confusing to use vma_flags_test_any_single_mask() for
this (and vma_flags_test_all_mask() is not correct to use here, as it
trivially returns true when tested against an empty vma flags mask).

We introduce vma_flags_count() to be able to assert that the compared flag
mask is singular or empty, checked when CONFIG_DEBUG_VM is enabled.

Also update the VMA tests as part of this change.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 46 ++++++++++++++++++++++++++++++
 tools/testing/vma/include/custom.h |  6 ----
 tools/testing/vma/include/dup.h    | 21 ++++++++++++++
 tools/testing/vma/vma_internal.h   |  6 ++++
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 47bf9f166924..324b6e8a66fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1083,6 +1083,14 @@ static __always_inline vma_flags_t __mk_vma_flags(vma_flags_t flags,
 #define append_vma_flags(flags, ...) __mk_vma_flags(flags,			\
 		COUNT_ARGS(__VA_ARGS__), (const vma_flag_t []){__VA_ARGS__})
 
+/* Calculates the number of set bits in the specified VMA flags. */
+static __always_inline int vma_flags_count(const vma_flags_t *flags)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+
+	return bitmap_weight(bitmap, NUM_VMA_FLAG_BITS);
+}
+
 /*
  * Test whether a specific VMA flag is set, e.g.:
  *
@@ -1158,6 +1166,26 @@ static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
 #define vma_flags_test_all(flags, ...) \
 	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+/*
+ * Helper to test that a flag mask of type vma_flags_t has a SINGLE flag set
+ * (returning false if flagmask has no flags set).
+ *
+ * This is defined to make the semantics clearer when testing an optionally
+ * defined VMA flags mask, e.g.:
+ *
+ * if (vma_flags_test_single_mask(&flags, VMA_DROPPABLE)) { ... }
+ *
+ * When VMA_DROPPABLE is defined if available, or set to EMPTY_VMA_FLAGS
+ * otherwise.
+ */
+static __always_inline bool vma_flags_test_single_mask(const vma_flags_t *flags,
+		vma_flags_t flagmask)
+{
+	VM_WARN_ON_ONCE(vma_flags_count(&flagmask) > 1);
+
+	return vma_flags_test_any_mask(flags, flagmask);
+}
+
 /* Set each of the to_set flags in flags, non-atomically. */
 static __always_inline void vma_flags_set_mask(vma_flags_t *flags,
 		vma_flags_t to_set)
@@ -1286,6 +1314,24 @@ static __always_inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 #define vma_test_all(vma, ...) \
 	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+/*
+ * Helper to test that a flag mask of type vma_flags_t has a SINGLE flag set
+ * (returning false if flagmask has no flags set).
+ *
+ * This is useful when a flag needs to be either defined or not depending upon
+ * kernel configuration, e.g.:
+ *
+ * if (vma_test_single_mask(vma, VMA_DROPPABLE)) { ... }
+ *
+ * When VMA_DROPPABLE is defined if available, or set to EMPTY_VMA_FLAGS
+ * otherwise.
+ */
+static __always_inline bool
+vma_test_single_mask(const struct vm_area_struct *vma, vma_flags_t flagmask)
+{
+	return vma_flags_test_single_mask(&vma->flags, flagmask);
+}
+
 /*
  * Helper to set all VMA flags in a VMA.
  *
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 2c498e713fbd..b7d9eb0a44e4 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -15,12 +15,6 @@ extern unsigned long dac_mmap_min_addr;
 #define dac_mmap_min_addr	0UL
 #endif
 
-#define VM_WARN_ON(_expr) (WARN_ON(_expr))
-#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
-#define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
-#define VM_BUG_ON(_expr) (BUG_ON(_expr))
-#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
-
 #define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
 
 /*
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index f9fe07a8a443..244ee02dc21d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -905,6 +905,13 @@ static __always_inline vma_flags_t __mk_vma_flags(vma_flags_t flags,
 #define append_vma_flags(flags, ...) __mk_vma_flags(flags,			\
 		COUNT_ARGS(__VA_ARGS__), (const vma_flag_t []){__VA_ARGS__})
 
+static __always_inline int vma_flags_count(const vma_flags_t *flags)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+
+	return bitmap_weight(bitmap, NUM_VMA_FLAG_BITS);
+}
+
 static __always_inline bool vma_flags_test(const vma_flags_t *flags,
 		vma_flag_t bit)
 {
@@ -952,6 +959,14 @@ static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
 #define vma_flags_test_all(flags, ...) \
 	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline bool vma_flags_test_single_mask(const vma_flags_t *flags,
+						vma_flags_t flagmask)
+{
+	VM_WARN_ON_ONCE(vma_flags_count(&flagmask) > 1);
+
+	return vma_flags_test_any_mask(flags, flagmask);
+}
+
 static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
 {
 	unsigned long *bitmap = flags->__vma_flags;
@@ -1031,6 +1046,12 @@ static __always_inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 #define vma_test_all(vma, ...) \
 	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline bool
+vma_test_single_mask(const struct vm_area_struct *vma, vma_flags_t flagmask)
+{
+	return vma_flags_test_single_mask(&vma->flags, flagmask);
+}
+
 static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 		vma_flags_t flags)
 {
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 0e1121e2ef23..e12ab2c80f95 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -51,6 +51,12 @@ typedef unsigned long	pgprotval_t;
 typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 typedef __bitwise unsigned int vm_fault_t;
 
+#define VM_WARN_ON(_expr) (WARN_ON(_expr))
+#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
+#define VM_BUG_ON(_expr) (BUG_ON(_expr))
+#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
+
 #include "include/stubs.h"
 #include "include/dup.h"
 #include "include/custom.h"
-- 
2.53.0


