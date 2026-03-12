Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C8106ACE0
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pXNtwefo3DI5PZqVhmiWEXF190WSl3hBxhRdARXxK9g=; b=RPW/dUOdYZX2GZYnEIsPBDnRvG
	nZgArmUz73MnWAOM9XpfEkWwlPDZ+0Gts4n315qrOTkTOAETWWKjsNTAJt0MvlkVfkehq4ecGemsL
	djcRKDPpvI0tW8qultluqhJjCZ25GcsSYGFv4YQoW8h7S2+OYBdwHYOXAxoz0IqaIPiHrMktQnxQg
	F+x+dJ06DmBGwZ1pLDpYOwL9Cq2Eo3bRTfRTAOdPPtDq2YgxXK01/df1EGN2mkBJZEgX/z/wh5cYg
	Gh8QEM8lAEogLAFv+fWlMRyh1vpGLBeASAECe2OIi0CB7dEJdsFLJGQk1dE57PGs08hkaep/hQSo2
	I4qypQRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWw-0000000F1ND-35h0;
	Thu, 12 Mar 2026 19:17:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lWl-0000000F15I-0Xet;
	Thu, 12 Mar 2026 19:17:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3BDB44517;
	Thu, 12 Mar 2026 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126E0C2BC9E;
	Thu, 12 Mar 2026 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343018;
	bh=cMZvtYTbVi8gGI62iqsWZ4caZrMQ/fPLlqyhjNcRyx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEiK7/n40R+U6XNkiSalA/AXJ/bEgYclxYDzCqR94yWMygwmC794VCL0NxoNYMt3J
	 RHgWYcxQkKel2D7y5Qt7KDsDDMbbnor8tS00TxPxTu7yixFOVnFjv/PAKh+RDo3tpd
	 yGc6lmIpIhzsiJVtCyAB02NBMWdKtc6jRMZms3t37fq7iqSAm8xvmcKPPar1qbfOd9
	 EvzQJ8XXrWFAYsPwnjWKyAaJA6DLfoLru6ENVdQxEMDyebpaZ7Ji0O9VLo8T3kTXXo
	 yolKRFYDkMz5uAmNg47v7Mny0fse4ZkcVEuNAaoLI86leo+dqL+SZpfMRoIRQSV5f/
	 wEw5+9/hlVO1A==
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
Subject: [PATCH 10/20] mm/vma: introduce vma_flags_same[_mask/_pair]()
Date: Thu, 12 Mar 2026 19:16:08 +0000
Message-ID: <64129ea327a7280732291e3481f1fd138aaf4caa.1773342102.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773342102.git.ljs@kernel.org>
References: <cover.1773342102.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_121659_514401_0BCCBE30 
X-CRM114-Status: GOOD (  14.55  )
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

Add helpers to determine if two sets of VMA flags are precisely the same,
that is - that every flag set one is set in another, and neither contain
any flags not set in the other.

We also introduce vma_flags_same_pair() for cases where we want to compare
two sets of VMA flags which are both non-const values.

Also update the VMA tests to reflect the change, we already implicitly test
that this functions correctly having used it for testing purposes
previously.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 28 ++++++++++++++++++++++++++++
 tools/testing/vma/include/custom.h | 12 ------------
 tools/testing/vma/include/dup.h    | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c16c744d49d..33d0c2af2c75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1209,6 +1209,34 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+/* Determine if flags and flags_other have precisely the same flags set. */
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/* Determine if flags and flags_other have precisely the same flags set.  */
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Helper macro to determine if only the specific flags are set, e.g.:
+ *
+ * if (vma_flags_same(&flags, VMA_WRITE_BIT) { ... }
+ */
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Helper to test that ALL specified flags are set in a VMA.
  *
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 433b3396c281..92fe156ed7d6 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -99,17 +99,5 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 	if (reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
-
-/* Place here until needed in the kernel code. */
-static __always_inline bool vma_flags_same_mask(vma_flags_t *flags,
-						vma_flags_t flags_other)
-{
-	const unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_other = flags_other.__vma_flags;
-
-	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
-}
-#define vma_flags_same(flags, ...) \
-	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 #define VMA_SPECIAL_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_DONTEXPAND_BIT, \
 				       VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c3be8a2381e1..fa2df96f9dee 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -951,6 +951,27 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 				     vma_flags_t flags)
 {
-- 
2.53.0


