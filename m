Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9650B103E19F
	for <linux-um@archiver.kernel.org>; Wed, 18 Mar 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kumeaz3F9F5JjBGagKwwJBC9S1mTUi+FKhMAfdlAoeU=; b=Crk1YLK5sw/PBLYSRw8prEuODe
	6TiW5ztY5cog93Zr4nRQ5DeMb9yK+Mk/h16ZtdT5x7HrxFbXd7ElUuf+lSvXveuTthB/Sgjp9gnjD
	ahxCXGV3ZOOXYcOeAmYIv4g7jsosNrHdUxGF3um8C9tH5hDs1lykLIvJBrKL+u/HftVfnqQUWje56
	geOJxTbZ3CrgNH3C7TcnSCu+Pv+eKW5Z0YE5rcza4zEZuUy1n92WWVZ0CRU7M8x2J6aMHdv3BR7dV
	eSZp0FdJnSIGJA8n4pdVXyKTS1cl3LNLwTP2VIAHDnrbTezogMmeZoOKngx8/VWN4jWHlFvBXk8NO
	n1RC804Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2tB3-00000008lnT-3nga;
	Wed, 18 Mar 2026 15:51:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2tAu-00000008lYF-30WC;
	Wed, 18 Mar 2026 15:51:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C4EA0439C9;
	Wed, 18 Mar 2026 15:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E17C2BCAF;
	Wed, 18 Mar 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849071;
	bh=nrs6iJ/XdiJB/0ese2zp+YaeuL3aT0WXZzGBimGG+OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bgl0CnFw2w9iWUKNyKcHV0ooDagsFya2kSGZSYS7wnv4UhCgV18vg76y6TBaqtIZd
	 O5lQWXgBUJyqGSyaju2M6OQARsj3bWDWDwtDGHo/pVVg3fk3bPy5v78bx1HdGc2Y5K
	 MJQJqe1DZVubyhOly75eGjM04WgpWjWwi+B6eqJYWuiCPReF2fliFBIeUinwFnu6/N
	 XuDVbwq/SckZdhjf5HM5g6fNLXJxjt/aDSy1IymOy1wEUDWGZEnX+eQu6PXw57Jg4i
	 oT3zLzACxdFXlhf5OF6zdvkmS4vxnmgj3U4aAWBq2muCepbEkLB9JJ/yEB1vWWKMPa
	 LotP1Xt38hFGA==
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
Subject: [PATCH v3 11/23] mm/vma: introduce [vma_flags,legacy]_to_[legacy,vma_flags]() helpers
Date: Wed, 18 Mar 2026 15:50:22 +0000
Message-ID: <4fdffd05ee7fabe2dc313850a4300bf184beba69.1773846935.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773846935.git.ljs@kernel.org>
References: <cover.1773846935.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_085112_851735_02ED2D2E 
X-CRM114-Status: GOOD (  15.18  )
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

While we are still converting VMA flags from vma_flags_t to vm_flags_t,
introduce helpers to convert between the two to allow for iterative
development without having to 'change the world' in a single commit'.

Also update VMA flags tests to reflect the change.

Finally, refresh vma_flags_overwrite_word(),
vma_flag_overwrite_word_once(), vma_flags_set_word() and
vma_flags_clear_word() in the VMA tests to reflect current kernel
implementations - this should make no functional difference, but keeps the
logic consistent between the two.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm_types.h        | 26 ++++++++++++++++++++++++
 tools/testing/vma/include/dup.h | 36 +++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 47d64057b74c..c5ad55b8a45b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1069,6 +1069,18 @@ static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
 }
 
+/*
+ * Helper function which converts a vma_flags_t value to a legacy vm_flags_t
+ * value. This is only valid if the input flags value can be expressed in a
+ * system word.
+ *
+ * Will be removed once the conversion to VMA flags is complete.
+ */
+static __always_inline vm_flags_t vma_flags_to_legacy(vma_flags_t flags)
+{
+	return (vm_flags_t)flags.__vma_flags[0];
+}
+
 /*
  * Copy value to the first system word of VMA flags, non-atomically.
  *
@@ -1082,6 +1094,20 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
 	bitmap[0] = value;
 }
 
+/*
+ * Helper function which converts a legacy vm_flags_t value to a vma_flags_t
+ * value.
+ *
+ * Will be removed once the conversion to VMA flags is complete.
+ */
+static __always_inline vma_flags_t legacy_to_vma_flags(vm_flags_t flags)
+{
+	vma_flags_t ret = EMPTY_VMA_FLAGS;
+
+	vma_flags_overwrite_word(&ret, flags);
+	return ret;
+}
+
 /*
  * Copy value to the first system word of VMA flags ONCE, non-atomically.
  *
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 65f630923461..f49af21319ba 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -766,7 +766,9 @@ static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
  */
 static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
 {
-	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+	unsigned long *bitmap = flags->__vma_flags;
+
+	bitmap[0] = value;
 }
 
 /*
@@ -777,7 +779,7 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
  */
 static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	WRITE_ONCE(*bitmap, value);
 }
@@ -785,7 +787,7 @@ static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned lo
 /* Update the first system word of VMA flags setting bits, non-atomically. */
 static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	*bitmap |= value;
 }
@@ -793,7 +795,7 @@ static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 /* Update the first system word of VMA flags clearing bits, non-atomically. */
 static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	*bitmap &= ~value;
 }
@@ -803,6 +805,32 @@ static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
 }
 
+/*
+ * Helper function which converts a vma_flags_t value to a legacy vm_flags_t
+ * value. This is only valid if the input flags value can be expressed in a
+ * system word.
+ *
+ * Will be removed once the conversion to VMA flags is complete.
+ */
+static __always_inline vm_flags_t vma_flags_to_legacy(vma_flags_t flags)
+{
+	return (vm_flags_t)flags.__vma_flags[0];
+}
+
+/*
+ * Helper function which converts a legacy vm_flags_t value to a vma_flags_t
+ * value.
+ *
+ * Will be removed once the conversion to VMA flags is complete.
+ */
+static __always_inline vma_flags_t legacy_to_vma_flags(vm_flags_t flags)
+{
+	vma_flags_t ret = EMPTY_VMA_FLAGS;
+
+	vma_flags_overwrite_word(&ret, flags);
+	return ret;
+}
+
 static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
 		vma_flag_t bit)
 {
-- 
2.53.0


