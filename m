Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4D8F506CC
	for <linux-um@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9QvXvbQXTFua9r/EcOpIsdNUq/kROMUQCN4Aaq/xOg=; b=1oeRd51QslArnHV5T2y9PukZY7
	yiM3ApR3BFMjjqZlfpLnhw4uITJtsMsUYftvslfwbiaYILQ/C4065HBFrz9JrK+2TOCmVDFTc25Ha
	FUpg3t0Jg+5Zgvc/X48r2auav4AeVaAEv9btJ9iVUbxeiuVpy4171UuYSCxils7etcbhEMRi14du1
	99UXDqrAEOSEwQizahjDFWKVLFT2qvCUx5dhHbD9rQb8gvSVQXdL2n9NGTXQOe9Gdj9GSUGoEH3o2
	RXet+mmE1YuoJVfOdkEcJFcDTKZ0PGZxXwg6GOSH8gEMSu1IBpLYPa+ZZEwS3aACvy8pSYJXNKA+6
	g3x6uC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27gs-000000040Pn-28Z9;
	Mon, 16 Mar 2026 13:09:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27gn-000000040Ls-3Fmy;
	Mon, 16 Mar 2026 13:08:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 59F4941A1C;
	Mon, 16 Mar 2026 13:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F7EC19425;
	Mon, 16 Mar 2026 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666536;
	bh=+rncZdS3jjEKtWi8jdnOMFhYY7y/QqdUgMyj9l/Hlaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXrqpZM+9CbywSbapkgjT3VDzretBbIcNDn3fSPRXkVkEgXkNF3PTa9ENV2UVOBq3
	 8wBLEQRgtFudPr2zl3Dv2JmCG75DiS9a+lRv+Y6FNGuZ2tsjzhwIm5yZCT4mPUW87O
	 YbNUE2mdhmW3cWvxzCQAxZAsHUEvanIYdAbbFNtsYGPETPKQnz0QZZjkzEVNVZXHhM
	 eJSP3fVYNnV6J4vRrDdp3SpACcGsUI4zmoYqsbHLXDSHIbbO0KV7L28ruOCANjePsu
	 xB1yvfAKdfEoI2nGlsIcWZR+b+0aVAoaHdqjt1afOC82WMJqOuhhILHmCWhHo1HAGK
	 hqs9Be3QCvaDw==
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
Subject: [PATCH v2 01/23] mm/vma: add vma_flags_empty(), vma_flags_and(), vma_flags_diff_pair()
Date: Mon, 16 Mar 2026 13:07:50 +0000
Message-ID: <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_060857_955152_1DE28EAA 
X-CRM114-Status: GOOD (  21.09  )
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

Firstly, add the ability to determine if VMA flags are empty, that is no
flags are set in a vma_flags_t value.

Next, add the ability to obtain the equivalent of the bitwise and of two
vma_flags_t values, via vma_flags_and().

Next, add the ability to obtain the difference between two sets of VMA
flags, that is the equivalent to the exclusive bitwise OR of the two sets
of flags, via vma_flags_diff_pair().

vma_flags_xxx_mask() typically operates on a pointer to a vma_flags_t
value, which is assumed to be an lvalue of some kind (such as a field in a
struct or a stack variable) and an rvalue of some kind (typically a
constant set of VMA flags obtained e.g. via mk_vma_flags() or equivalent).

However vma_flags_diff_pair() is intended to operate on two lvalues, so use
the _pair() suffix to make this clear.

Finally, update VMA userland tests to add these helpers.

We also port bitmap_xor() and __bitmap_xor() to the tools/ headers and
source to allow the tests to work with vma_flags_diff_pair().

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h              | 60 ++++++++++++++++++++++++++++-----
 include/linux/mm_types.h        |  8 +++++
 tools/include/linux/bitmap.h    | 13 +++++++
 tools/lib/bitmap.c              | 10 ++++++
 tools/testing/vma/include/dup.h | 36 +++++++++++++++++++-
 5 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 70747b53c7da..6d2c4bd2c61d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1053,6 +1053,19 @@ static __always_inline vma_flags_t __mk_vma_flags(size_t count,
 	return flags;
 }
 
+/*
+ * Helper macro which bitwise-or combines the specified input flags into a
+ * vma_flags_t bitmap value. E.g.:
+ *
+ * vma_flags_t flags = mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,
+ *              VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+ *
+ * The compiler cleverly optimises away all of the work and this ends up being
+ * equivalent to aggregating the values manually.
+ */
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
 /*
  * Test whether a specific VMA flag is set, e.g.:
  *
@@ -1067,17 +1080,30 @@ static __always_inline bool vma_flags_test(const vma_flags_t *flags,
 }
 
 /*
- * Helper macro which bitwise-or combines the specified input flags into a
- * vma_flags_t bitmap value. E.g.:
- *
- * vma_flags_t flags = mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,
- * 		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+ * Obtain a set of VMA flags which contain the overlapping flags contained
+ * within flags and to_and.
+ */
+static __always_inline vma_flags_t vma_flags_and_mask(const vma_flags_t *flags,
+						      vma_flags_t to_and)
+{
+	vma_flags_t dst;
+	unsigned long *bitmap_dst = dst.__vma_flags;
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_and = to_and.__vma_flags;
+
+	bitmap_and(bitmap_dst, bitmap, bitmap_to_and, NUM_VMA_FLAG_BITS);
+	return dst;
+}
+
+/*
+ * Obtain a set of VMA flags which contains the specified overlapping flags,
+ * e.g.:
  *
- * The compiler cleverly optimises away all of the work and this ends up being
- * equivalent to aggregating the values manually.
+ * vma_flags_t read_flags = vma_flags_and(&flags, VMA_READ_BIT,
+ *                                        VMA_MAY_READ_BIT);
  */
-#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
-					 (const vma_flag_t []){__VA_ARGS__})
+#define vma_flags_and(flags, ...)				\
+	vma_flags_and_mask(flags, mk_vma_flags(__VA_ARGS__))
 
 /*  Test each of to_test flags in flags, non-atomically. */
 static __always_inline bool vma_flags_test_any_mask(const vma_flags_t *flags,
@@ -1151,6 +1177,22 @@ static __always_inline void vma_flags_clear_mask(vma_flags_t *flags,
 #define vma_flags_clear(flags, ...) \
 	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+/*
+ * Obtain a VMA flags value containing those flags that are present in flags or
+ * flags_other but not in both.
+ */
+static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
+		const vma_flags_t *flags_other)
+{
+	vma_flags_t dst;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+	const unsigned long *bitmap = flags->__vma_flags;
+	unsigned long *bitmap_dst = dst.__vma_flags;
+
+	bitmap_xor(bitmap_dst, bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+	return dst;
+}
+
 /*
  * Helper to test that ALL specified flags are set in a VMA.
  *
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3944b51ebac6..ad414ff2d815 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -870,6 +870,14 @@ typedef struct {
 
 #define EMPTY_VMA_FLAGS ((vma_flags_t){ })
 
+/* Are no flags set in the specified VMA flags? */
+static __always_inline bool vma_flags_empty(vma_flags_t *flags)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+
+	return bitmap_empty(bitmap, NUM_VMA_FLAG_BITS);
+}
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 250883090a5d..845eda759f67 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -28,6 +28,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int nbits);
+void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+		  const unsigned long *bitmap2, unsigned int nbits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -209,4 +211,15 @@ static inline void bitmap_clear(unsigned long *map, unsigned int start,
 	else
 		__bitmap_clear(map, start, nbits);
 }
+
+static __always_inline
+void bitmap_xor(unsigned long *dst, const unsigned long *src1,
+		const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		*dst = *src1 ^ *src2;
+	else
+		__bitmap_xor(dst, src1, src2, nbits);
+}
+
 #endif /* _TOOLS_LINUX_BITMAP_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index aa83d22c45e3..fedc9070f0e4 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -169,3 +169,13 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 			return false;
 	return true;
 }
+
+void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] ^ bitmap2[k];
+}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 8865ffe046d8..13c03bf247bc 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -422,6 +422,13 @@ struct vma_iterator {
 #define MAPCOUNT_ELF_CORE_MARGIN	(5)
 #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
 
+static __always_inline bool vma_flags_empty(vma_flags_t *flags)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+
+	return bitmap_empty(bitmap, NUM_VMA_FLAG_BITS);
+}
+
 /* What action should be taken after an .mmap_prepare call is complete? */
 enum mmap_action_type {
 	MMAP_NOTHING,		/* Mapping is complete, no further action. */
@@ -855,6 +862,21 @@ static __always_inline bool vma_flags_test(const vma_flags_t *flags,
 	return test_bit((__force int)bit, bitmap);
 }
 
+static __always_inline vma_flags_t vma_flags_and_mask(const vma_flags_t *flags,
+						      vma_flags_t to_and)
+{
+	vma_flags_t dst;
+	unsigned long *bitmap_dst = dst.__vma_flags;
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_and = to_and.__vma_flags;
+
+	bitmap_and(bitmap_dst, bitmap, bitmap_to_and, NUM_VMA_FLAG_BITS);
+	return dst;
+}
+
+#define vma_flags_and(flags, ...)		\
+	vma_flags_and_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 static __always_inline bool vma_flags_test_any_mask(const vma_flags_t *flags,
 		vma_flags_t to_test)
 {
@@ -901,8 +923,20 @@ static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t
 #define vma_flags_clear(flags, ...) \
 	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
+		const vma_flags_t *flags_other)
+{
+	vma_flags_t dst;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+	const unsigned long *bitmap = flags->__vma_flags;
+	unsigned long *bitmap_dst = dst.__vma_flags;
+
+	bitmap_xor(bitmap_dst, bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+	return dst;
+}
+
 static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
-					   vma_flags_t flags)
+				     vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&vma->flags, flags);
 }
-- 
2.53.0


